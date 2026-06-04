// import 'package:expense_flow/features/dashboard/domain/enities/transaction_entity.dart';
// import 'package:expense_flow/features/dashboard/presentation/widgets/transaction_tile.dart';
// import 'package:flutter/material.dart';

// class RecentTransactionsSection extends StatelessWidget {
//   final List<TransactionEntity> transactions;

//   const RecentTransactionsSection({super.key, required this.transactions});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Recent Transactions',
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//         const SizedBox(height: 12),

//         ...transactions.map(
//           (transaction) => TransactionTile(transaction: transaction),
//         ),
//       ],
//     );
//   }
// }

import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:expense_flow/features/dashboard/presentation/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';

class RecentTransactionsSection extends StatelessWidget {
  const RecentTransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'View All',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.lightSurface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: const [
              TransactionTile(
                icon: '💰',
                title: 'Salary',
                amount: '+ ₹50,000',
                category: 'Income',
                time: '06:35 AM',
                isIncome: true,
              ),
              Divider(height: 1),
              TransactionTile(
                icon: '🎬',
                title: 'Burger',
                amount: '- ₹390',
                category: 'Expense',
                time: '05:53 AM',
                isIncome: false,
              ),
              Divider(height: 1),
              TransactionTile(
                icon: '🎬',
                title: 'Burger',
                amount: '- ₹390',
                category: 'Expense',
                time: '05:51 AM',
                isIncome: false,
              ),
              Divider(height: 1),
              TransactionTile(
                icon: '🎬',
                title: 'Burger',
                amount: '- ₹390',
                category: 'Expense',
                time: '05:48 AM',
                isIncome: false,
              ),
              Divider(height: 1),
              TransactionTile(
                icon: '💡',
                title: 'Burger King',
                amount: '- ₹250',
                category: 'Expense',
                time: '05:41 AM',
                isIncome: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
