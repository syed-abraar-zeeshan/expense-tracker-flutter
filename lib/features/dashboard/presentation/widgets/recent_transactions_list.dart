import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:expense_flow/core/theme/app_dimensions.dart';
import 'package:expense_flow/core/utils/app_currency_formatter.dart';
import 'package:expense_flow/features/dashboard/domain/enities/transaction_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class RecentTransactionsList extends StatelessWidget {
  final List<TransactionEntity> transactions;
  final String symbol;
  final double conversionRate;

  const RecentTransactionsList({super.key, required this.transactions, required this.symbol, required this.conversionRate});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (transactions.isEmpty) {
      return Center(
        child: Column(
          children: [
            const Gap(AppDimensions.xl),
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: theme.disabledColor,
            ),
            const Gap(AppDimensions.md),
            Text('No recent transactions', style: theme.textTheme.bodyLarge),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      separatorBuilder: (context, index) => const Gap(AppDimensions.sm),
      itemBuilder: (context, index) {
        final tx = transactions[index];
        final isIncome = tx.type.toLowerCase() == 'income';
        // Default to error/red if not explicitly income
        final color = isIncome ? AppColors.success : AppColors.error;

        return InkWell(
          onTap: () => context.push('/edit-expense', extra: tx),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.sm),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              border: Border.all(color: theme.dividerColor.withValues(alpha: 0.05)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isIncome
                        ? Icons.account_balance_wallet_outlined
                        : Icons.shopping_bag_outlined,
                    color: color,
                    size: 24,
                  ),
                ),
                const Gap(AppDimensions.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMd().format(tx.date),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Text(
                  '${isIncome ? '+' : '-'} ${AppCurrencyFormatter.format(tx.amount.abs(), symbol: symbol, conversionRate: conversionRate)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.05);
      },
    );
  }
}
