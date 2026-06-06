import 'package:expense_flow/core/theme/app_dimensions.dart';
import 'package:expense_flow/core/widgets/floating_bottom_nav_bar.dart';
import 'package:expense_flow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:expense_flow/features/settings/presentation/controllers/currency_controller.dart';
import 'package:expense_flow/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/balance_card.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/financial_summary_section.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/quick_actions_grid.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/recent_transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      ref.read(authControllerProvider.notifier).getProfile();
      ref.read(dashboardControllerProvider.notifier).getDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Optimization: Using .select to only rebuild when specific data changes
    final user = ref.watch(authControllerProvider.select((s) => s.user));
    final dashboard = ref.watch(
      dashboardControllerProvider.select((s) => s.dashboard),
    );
    final currency = ref.watch(currencyControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () =>
              ref.read(dashboardControllerProvider.notifier).getDashboard(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(AppDimensions.md),

                // 1. Greeting Header
                DashboardHeader(user: user),

                const Gap(AppDimensions.lg),

                // 2. Premium Balance Card
                BalanceCard(
                  balance: dashboard?.balance ?? 0.0,
                  symbol: currency.symbol,
                  conversionRate: currency.conversionRate,
                ),

                const Gap(AppDimensions.lg),

                // 3. Financial Summary
                FinancialSummarySection(
                  income: dashboard?.totalIncome ?? 0.0,
                  expense: dashboard?.totalExpense ?? 0.0,
                  symbol: currency.symbol,
                  conversionRate: currency.conversionRate,
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),

                const Gap(AppDimensions.xl),

                // 4. Quick Actions
                const QuickActionsGrid().animate().fadeIn(delay: 300.ms),

                const Gap(AppDimensions.xl),

                // 5. Recent Transactions Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Transactions',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.push('/expenses'),
                      child: const Text('See All'),
                    ),
                  ],
                ),

                // 6. Recent Transactions List
                RecentTransactionsList(
                  transactions: dashboard?.recentTransactions ?? [],
                  symbol: currency.symbol,
                  conversionRate: currency.conversionRate,
                ),

                const Gap(100), // Spacing for floating nav bar
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: FloatingBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          if (_selectedIndex == index) return;
          setState(() => _selectedIndex = index);
          if (index == 1) context.push('/expenses');
          if (index == 2) context.push('/categories');
          if (index == 3) context.push('/profile');
        },
        items: const [
          FloatingBottomNavItem(
            activeIcon: Icons.home_rounded,
            inactiveIcon: Icons.home_outlined,
            label: 'Home',
          ),
          FloatingBottomNavItem(
            activeIcon: Icons.receipt_long_rounded,
            inactiveIcon: Icons.receipt_long_outlined,
            label: 'Expenses',
          ),
          FloatingBottomNavItem(
            activeIcon: Icons.pie_chart_rounded,
            inactiveIcon: Icons.pie_chart_outline_rounded,
            label: 'Categories',
          ),
          FloatingBottomNavItem(
            activeIcon: Icons.person_rounded,
            inactiveIcon: Icons.person_outline_rounded,
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add-expense'),
        elevation: 8,
        shape: const CircleBorder(),
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF5D5FEF), Color(0xFF7000FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ).animate().scale(delay: 400.ms, curve: Curves.easeOutBack),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
