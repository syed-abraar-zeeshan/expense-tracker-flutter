import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:expense_flow/features/dashboard/domain/enities/transaction_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type.toLowerCase() == 'income';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: isIncome 
              ? AppColors.success.withOpacity(0.1) 
              : AppColors.error.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            transaction.category.icon,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
      title: Text(
        transaction.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        DateFormat('dd MMM yyyy, hh:mm a').format(transaction.date),
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            isIncome ? '+ ₹${transaction.amount}' : '- ₹${transaction.amount}',
            style: TextStyle(
              color: isIncome ? AppColors.success : AppColors.error,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: isIncome
                  ? AppColors.success.withOpacity(0.08)
                  : AppColors.error.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              transaction.category.name,
              style: TextStyle(
                fontSize: 12,
                color: isIncome ? AppColors.success : AppColors.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
