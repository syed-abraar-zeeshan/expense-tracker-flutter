import 'package:expense_flow/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Flow',
      debugShowCheckedModeBanner: false,

      // Inject our verified structural configurations
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      // This tells Flutter to read the native OS configuration (Light or Dark)
      themeMode: ThemeMode.system,

      home: const Scaffold(
        body: Center(child: Text('Design Token System Active')),
      ),
    );
  }
}
