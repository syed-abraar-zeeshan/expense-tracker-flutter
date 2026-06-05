import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  final bool isLoading;
  final bool isExpanded;

  final Widget? icon;

  final double? width;
  final double height;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final EdgeInsetsGeometry? padding;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isExpanded = true,
    this.icon,
    this.width,
    this.height = 56,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final buttonContent = isLoading
        ? const SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 8)],
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );

    final buttonStyle = ElevatedButton.styleFrom(
      minimumSize: Size(width ?? 0, height),
      backgroundColor: backgroundColor ?? Colors.transparent,
      foregroundColor: foregroundColor ?? Colors.white,
      shadowColor: Colors.transparent,
      elevation: 0,
      padding: padding,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );

    final widget = Container(
      decoration: BoxDecoration(
        gradient: backgroundColor == null
            ? const LinearGradient(
                colors: [
                  AppColors.balanceGradientStart,
                  AppColors.balanceGradientEnd,
                ],
              )
            : null,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isLoading && onPressed != null)
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        child: buttonContent,
      ),
    );

    return isExpanded
        ? SizedBox(width: double.infinity, child: widget)
        : widget;
  }
}
