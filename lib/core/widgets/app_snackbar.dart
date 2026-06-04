import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum SnackbarType { success, error, info, warning }

class AppSnackbar {
  AppSnackbar._();

  static void show(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.info,
  }) {
    Color backgroundColor;

    switch (type) {
      case SnackbarType.success:
        backgroundColor = AppColors.success;
        break;

      case SnackbarType.error:
        backgroundColor = AppColors.error;
        break;

      case SnackbarType.warning:
        backgroundColor = AppColors.warning;
        break;

      case SnackbarType.info:
        backgroundColor = AppColors.primary;
        break;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
  }
}
