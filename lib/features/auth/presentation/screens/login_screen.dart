import 'package:expense_flow/core/constants/app_strings.dart';
import 'package:expense_flow/core/theme/app_dimensions.dart';
import 'package:expense_flow/core/utils/app_validators.dart';
import 'package:expense_flow/core/widgets/app_button.dart';
import 'package:expense_flow/core/widgets/app_snackbar.dart';
import 'package:expense_flow/core/widgets/app_text_field.dart';
import 'package:expense_flow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:expense_flow/features/auth/presentation/forms/login_form_controller.dart';
import 'package:expense_flow/features/auth/presentation/providers/login_provider.dart';
import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:expense_flow/features/auth/presentation/widgets/auth_background.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final LoginFormController loginFormController;

  @override
  void initState() {
    super.initState();
    loginFormController = LoginFormController();
  }

  @override
  void dispose() {
    loginFormController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPasswordHidden = ref.watch(passwordVisibilityProvider);
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (previous, next) {
      if (next.errorMessage != null) {
        AppSnackbar.show(
          context,
          message: next.errorMessage!,
          type: SnackbarType.error,
        );
        ref.read(authControllerProvider.notifier).clearError();
      }
      if (next.isAuthenticated) {
        AppSnackbar.show(
          context,
          message: 'Login successful',
          type: SnackbarType.success,
        );
        context.go('/dashboard');
      }
    });

    return AuthBackground(
      title: 'Welcome Back',
      subtitle: AppStrings.trackExpensesSmarter,
      child: Form(
        key: loginFormController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppDimensions.md),
            AppTextField(
              controller: loginFormController.emailController,
              labelText: AppStrings.email,
              hintText: AppStrings.enterEmail,
              keyboardType: TextInputType.emailAddress,
              validator: AppValidators.email,
              prefixIcon: const Icon(Icons.email_outlined),
            ),
            const SizedBox(height: AppDimensions.lg),
            AppTextField(
              controller: loginFormController.passwordController,
              labelText: AppStrings.password,
              hintText: AppStrings.enterPassword,
              validator: AppValidators.password,
              obscureText: isPasswordHidden,
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                onPressed: () {
                  ref.read(passwordVisibilityProvider.notifier).toggle();
                },
                icon: Icon(
                  isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.sm),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  AppStrings.forgotPassword,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.md),
            AppButton(
              text: AppStrings.login,
              isLoading: authState.isLoading,
              onPressed: () {
                if (loginFormController.validate()) {
                  ref.read(authControllerProvider.notifier).login(
                        email: loginFormController.emailController.text.trim(),
                        password:
                            loginFormController.passwordController.text.trim(),
                      );
                }
              },
            ),
            const SizedBox(height: AppDimensions.xl),
            Center(
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    const TextSpan(text: AppStrings.dontHaveAccount),
                    TextSpan(
                      text: ' ${AppStrings.register}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.push('/register');
                        },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
