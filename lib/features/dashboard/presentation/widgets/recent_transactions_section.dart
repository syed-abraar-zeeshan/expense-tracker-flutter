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
          children: [
            Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            TextButton(onPressed: () {}, child: const Text('View All')),
          ],
        ),

        const SizedBox(height: 12),

        const TransactionTile(
          icon: '💰',
          title: 'Salary',
          amount: '+ ₹50,000',
          category: 'Income',
          isIncome: true,
        ),

        const TransactionTile(
          icon: '🎬',
          title: 'Burger',
          amount: '- ₹390',
          category: 'Expense',
          isIncome: false,
        ),

        const TransactionTile(
          icon: '🎬',
          title: 'Burger',
          amount: '- ₹390',
          category: 'Expense',
          isIncome: false,
        ),

        const TransactionTile(
          icon: '💡',
          title: 'Burger King',
          amount: '- ₹250',
          category: 'Expense',
          isIncome: false,
        ),
      ],
    );
  }
}
