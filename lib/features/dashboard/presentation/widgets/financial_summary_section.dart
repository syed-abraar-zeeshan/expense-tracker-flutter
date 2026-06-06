import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:expense_flow/core/theme/app_dimensions.dart';
import 'package:expense_flow/core/utils/app_currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FinancialSummarySection extends StatelessWidget {
  final double income;
  final double expense;
  final String symbol;
  final double conversionRate;

  const FinancialSummarySection({
    super.key,
    required this.income,
    required this.expense,
    required this.symbol,
    required this.conversionRate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SummaryItem(
          label: 'Income',
          amount: income,
          icon: Icons.arrow_downward_rounded,
          color: AppColors.success,
          symbol: symbol,
          conversionRate: conversionRate,
        ),
        const Gap(AppDimensions.md),
        _SummaryItem(
          label: 'Expense',
          amount: expense,
          icon: Icons.arrow_upward_rounded,
          color: AppColors.error,
          symbol: symbol,
          conversionRate: conversionRate,
        ),
      ],
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final double amount;
  final IconData icon;
  final Color color;
  final String symbol;
  final double conversionRate;

  const _SummaryItem({
    required this.label,
    required this.amount,
    required this.icon,
    required this.color,
    required this.symbol,
    required this.conversionRate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.md),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          border: Border.all(color: theme.dividerColor.withValues(alpha: 0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const Gap(AppDimensions.sm),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
            const Gap(4),
            Text(
              AppCurrencyFormatter.format(
                amount,
                symbol: symbol,
                conversionRate: conversionRate,
              ),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
