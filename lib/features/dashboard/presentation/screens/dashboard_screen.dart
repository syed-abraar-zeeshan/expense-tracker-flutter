import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/balance_card.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/recent_transactions_section.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/summary_card.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/transaction_count_card.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const DashboardHeader(name: 'Abraar'),
              const SizedBox(height: 24),
              const BalanceCard(balance: 48580),
              const SizedBox(height: 20),
              Row(
                children: const [
                  SummaryCard(
                    title: 'Income',
                    amount: 50000,
                    icon: Icons.trending_up,
                    color: AppColors.success,
                  ),
                  SizedBox(width: 16),
                  SummaryCard(
                    title: 'Expense',
                    amount: 1420,
                    icon: Icons.trending_down,
                    color: AppColors.error,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const TransactionCountCard(count: 5),
              const SizedBox(height: 24),
              const RecentTransactionsSection(),
              const SizedBox(height: 100), // Space for bottom nav
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
          color: AppColors.lightSurface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home_rounded, 'Home'),
            _buildNavItem(1, Icons.assignment_outlined, 'Expenses'),
            _buildNavItem(2, Icons.pie_chart_outline_rounded, 'Categories'),
            _buildNavItem(3, Icons.person_outline_rounded, 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? AppColors.primary : Colors.grey;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
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
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected) ...[
            const SizedBox(height: 4),
            Container(
              width: 20,
              height: 3,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ] else ...[
            const SizedBox(height: 7),
          ],
        ],
      ),
    );
  }
}
