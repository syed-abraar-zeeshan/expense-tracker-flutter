import 'package:expense_flow/core/constants/app_strings.dart';
import 'package:expense_flow/core/theme/app_dimensions.dart';
import 'package:expense_flow/core/utils/app_validators.dart';
import 'package:expense_flow/core/widgets/app_button.dart';
import 'package:expense_flow/core/widgets/app_text_field.dart';
import 'package:expense_flow/features/auth/presentation/forms/login_form_controller.dart';
import 'package:expense_flow/features/auth/presentation/providers/login_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final loginFormController = LoginFormController();

  void _login() {
    if (loginFormController.validate()) {
      debugPrint('Login Clicked');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPasswordHidden = ref.watch(passwordVisibilityProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.lg),
          child: Form(
            key: loginFormController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  AppStrings.appName,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: AppDimensions.sm),
                Text(
                  AppStrings.trackExpensesSmarter,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppDimensions.xl),
                AppTextField(
                  controller: loginFormController.emailController,
                  labelText: AppStrings.email,
                  hintText: AppStrings.enterEmail,
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidators.email,
                ),
                const SizedBox(height: AppDimensions.md),
                AppTextField(
                  controller: loginFormController.passwordController,
                  labelText: AppStrings.password,
                  hintText: AppStrings.enterPassword,
                  validator: AppValidators.password,
                  obscureText: isPasswordHidden,
                  suffixIcon: IconButton(
                    onPressed: () {
                      ref.read(passwordVisibilityProvider.notifier).toggle();
                    },
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.radiusMd),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(AppStrings.forgotPassword),
                  ),
                ),
                const SizedBox(height: AppDimensions.md),
                AppButton(text: AppStrings.login, onPressed: _login),
                const SizedBox(height: AppDimensions.lg),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        const TextSpan(text: AppStrings.dontHaveAccount),
                        TextSpan(
                          text: ' ${AppStrings.register}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
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
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
