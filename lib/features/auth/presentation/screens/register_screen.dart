import 'package:expense_flow/core/constants/app_strings.dart';
import 'package:expense_flow/core/theme/app_dimensions.dart';
import 'package:expense_flow/core/utils/app_validators.dart';
import 'package:expense_flow/core/widgets/app_button.dart';
import 'package:expense_flow/core/widgets/app_snackbar.dart';
import 'package:expense_flow/core/widgets/app_text_field.dart';
import 'package:expense_flow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:expense_flow/features/auth/presentation/forms/register_form_controller.dart';
import 'package:expense_flow/features/auth/presentation/providers/register_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerWidget {
  RegisterScreen({super.key});

  final registerFormController = RegisterFormController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPasswordHidden = ref.watch(passwordVisibilityProvider);
    final isConfirmPasswordHidden = ref.watch(
      confirmPasswordVisibilityProvider,
    );

    ref.listen(authControllerProvider, (previous, next) {
      if (next.errorMessage != null) {
        AppSnackbar.show(
          context,
          message: next.errorMessage!,
          type: SnackbarType.error,
        );
        ref.read(authControllerProvider.notifier).clearError();
      }
      if (next.isRegistered) {
        AppSnackbar.show(
          context,
          message: 'Registration successful',
          type: SnackbarType.success,
        );

        context.pop(); // back to login
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.lg),
          child: Form(
            key: registerFormController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  AppStrings.register,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: AppDimensions.sm),
                Text(
                  AppStrings.createAccountToContinue,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppDimensions.xl),
                AppTextField(
                  controller: registerFormController.nameController,
                  labelText: AppStrings.fullName,
                  hintText: AppStrings.enterName,
                  validator: AppValidators.required,
                ),
                const SizedBox(height: AppDimensions.md),
                AppTextField(
                  controller: registerFormController.emailController,
                  labelText: AppStrings.email,
                  hintText: AppStrings.enterEmail,
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidators.email,
                ),
                const SizedBox(height: AppDimensions.md),
                AppTextField(
                  controller: registerFormController.passwordController,
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
                const SizedBox(height: AppDimensions.md),
                AppTextField(
                  controller: registerFormController.confirmPasswordController,
                  labelText: AppStrings.confirmPassword,
                  hintText: AppStrings.confirmPassword,
                  validator: (value) {
                    return AppValidators.confirmPassword(
                      value,
                      registerFormController.passwordController.text,
                    );
                  },
                  obscureText: isConfirmPasswordHidden,
                  suffixIcon: IconButton(
                    onPressed: () {
                      ref
                          .read(confirmPasswordVisibilityProvider.notifier)
                          .toggle();
                    },
                    icon: Icon(
                      isConfirmPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.xl),
                AppButton(
                  text: AppStrings.register,
                  onPressed: () {
                    if (registerFormController.validate()) {
                      ref
                          .read(authControllerProvider.notifier)
                          .register(
                            name: registerFormController.nameController.text
                                .trim(),
                            email: registerFormController.emailController.text
                                .trim(),
                            password: registerFormController
                                .confirmPasswordController
                                .text
                                .trim(),
                          );
                    }
                  },
                ),
                const SizedBox(height: AppDimensions.lg),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        const TextSpan(text: AppStrings.dontHaveAccount),
                        TextSpan(
                          text: ' ${AppStrings.login}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.pop();
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
