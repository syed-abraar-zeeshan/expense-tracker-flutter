import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:expense_flow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:expense_flow/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/balance_card.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/recent_transactions_section.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/summary_card.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/transaction_count_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final authState = ref.watch(authControllerProvider);
    final dashboardState = ref.watch(dashboardControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.dashboardBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              DashboardHeader(name: authState.user?.name ?? 'User'),
              const SizedBox(height: 24),
              BalanceCard(balance: dashboardState.dashboard?.balance ?? 0.0),
              const SizedBox(height: 20),
              Row(
                children: [
                  SummaryCard(
                    title: 'Income',
                    amount: dashboardState.dashboard?.totalIncome ?? 0.0,
                    icon: Icons.north_east_rounded,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: 16),
                  SummaryCard(
                    title: 'Expense',
                    amount: dashboardState.dashboard?.totalExpense ?? 0.0,
                    icon: Icons.south_west_rounded,
                    color: AppColors.error,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TransactionCountCard(
                count: dashboardState.dashboard?.transactionCount ?? 0,
              ),
              const SizedBox(height: 8),
              RecentTransactionsSection(
                transactions:
                    dashboardState.dashboard?.recentTransactions ?? [],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home_rounded, 'Home'),
            _buildNavItem(1, Icons.receipt_long_rounded, 'Expenses'),
            _buildNavItem(2, Icons.pie_chart_rounded, 'Categories'),
            _buildNavItem(3, Icons.person_rounded, 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? AppColors.primary : Colors.grey.withOpacity(0.5);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _selectedIndex = index),
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: 28,
              height: 3,
              decoration: BoxDecoration(
                color: isSelected ? color : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
