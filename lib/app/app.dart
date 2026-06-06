import 'package:expense_flow/app/router.dart';
import 'package:expense_flow/core/constants/app_strings.dart';
import 'package:expense_flow/core/theme/app_theme.dart';
import 'package:expense_flow/features/settings/presentation/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseFlowApp extends ConsumerWidget {
  const ExpenseFlowApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);

    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
