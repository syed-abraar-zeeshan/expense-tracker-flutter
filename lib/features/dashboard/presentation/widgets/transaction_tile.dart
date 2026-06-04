import 'package:expense_flow/features/dashboard/domain/enities/transaction_entity.dart';
import 'package:flutter/material.dart';

// class TransactionTile extends StatelessWidget {
//   final TransactionEntity transaction;

//   const TransactionTile({super.key, required this.transaction});

//   @override
//   Widget build(BuildContext context) {
//     final isIncome = transaction.type == 'income';

//     return ListTile(
//       leading: CircleAvatar(child: Text(transaction.category.icon)),
//       title: Text(transaction.title),
//       subtitle: Text(transaction.category.name),
//       trailing: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Text(
//             '${isIncome ? '+' : '-'} ₹${transaction.amount}',
//             style: TextStyle(
//               color: isIncome ? Colors.green : Colors.red,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String icon;
  final String title;
  final String amount;
  final String category;
  final bool isIncome;

  const TransactionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.category,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(child: Text(icon)),
        title: Text(title),
        subtitle: const Text('03 Jun 2026'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount,
              style: TextStyle(
                color: isIncome ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isIncome
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: isIncome ? Colors.green : Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
