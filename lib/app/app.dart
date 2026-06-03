import 'package:expense_flow/app/router.dart';
import 'package:expense_flow/core/constants/app_strings.dart';
import 'package:expense_flow/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ExpenseFlowApp extends StatelessWidget {
  const ExpenseFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
