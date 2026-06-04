import 'package:expense_flow/features/dashboard/presentation/widgets/balance_card.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/recent_transactions_section.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/summary_card.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/transaction_count_card.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
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
                    color: Colors.green,
                  ),

                  SizedBox(width: 16),

                  SummaryCard(
                    title: 'Expense',
                    amount: 1420,
                    icon: Icons.trending_down,
                    color: Colors.red,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const TransactionCountCard(count: 5),

              const SizedBox(height: 24),

              const RecentTransactionsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
