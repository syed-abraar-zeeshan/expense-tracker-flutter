import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:expense_flow/core/theme/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ActionButton(
          label: 'Add',
          icon: Icons.add_rounded,
          onTap: () => context.push('/add-expense'),
        ),
        _ActionButton(label: 'Send', icon: Icons.send_rounded, onTap: () {}),
        _ActionButton(
          label: 'Bills',
          icon: Icons.receipt_rounded,
          onTap: () {},
        ),
        _ActionButton(
          label: 'More',
          icon: Icons.grid_view_rounded,
          onTap: () {},
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: 0.05),
              ),
            ),
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
        ),
        const Gap(8),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
