import 'package:expense_flow/core/widgets/app_button.dart';
import 'package:expense_flow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: AppButton(
          text: 'Logout',
          onPressed: () async {
            await ref.read(authControllerProvider.notifier).logout();

            if (context.mounted) {
              context.go('/');
            }
          },
        ),
      ),
    );
  }
}
