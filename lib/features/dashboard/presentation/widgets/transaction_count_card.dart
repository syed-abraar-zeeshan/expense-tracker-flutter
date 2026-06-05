import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TransactionCountCard extends StatelessWidget {
  final int count;

  const TransactionCountCard({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.transactionCountBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.transactionIconOrange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.receipt_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Transactions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
