import 'package:expense_flow/core/constants/app_strings.dart';
import 'package:expense_flow/core/theme/app_dimensions.dart';
import 'package:expense_flow/core/utils/app_validators.dart';
import 'package:expense_flow/core/widgets/app_button.dart';
import 'package:expense_flow/core/widgets/app_snackbar.dart';
import 'package:expense_flow/core/widgets/app_text_field.dart';
import 'package:expense_flow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:expense_flow/features/auth/presentation/forms/register_form_controller.dart';
import 'package:expense_flow/features/auth/presentation/providers/register_provider.dart';
import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
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
    final authState = ref.watch(authControllerProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
          message: 'Account created successfully!',
          type: SnackbarType.success,
        );
        context.pop(); // back to login
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Shapes
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondary.withValues(alpha: isDark ? 0.15 : 0.1),
                    AppColors.transparent,
                  ],
                ),
              ),
            ),
          ).animate().fadeIn(duration: 1000.ms).scale(begin: const Offset(0.5, 0.5)),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.lg),
              child: Form(
                key: registerFormController.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(AppDimensions.md),
                    
                    Text(
                      'Create Account',
                      style: theme.textTheme.displaySmall,
                    ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
                    
                    const Gap(AppDimensions.xs),
                    
                    Text(
                      AppStrings.createAccountToContinue,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.2),
                    
                    const Gap(AppDimensions.xl),
                    
                    AppTextField(
                      controller: registerFormController.nameController,
                      labelText: AppStrings.fullName,
                      hintText: AppStrings.enterName,
                      validator: AppValidators.required,
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
                    
                    const Gap(AppDimensions.md),
                    
                    AppTextField(
                      controller: registerFormController.emailController,
                      labelText: AppStrings.email,
                      hintText: AppStrings.enterEmail,
                      keyboardType: TextInputType.emailAddress,
                      validator: AppValidators.email,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),
                    
                    const Gap(AppDimensions.md),
                    
                    AppTextField(
                      controller: registerFormController.passwordController,
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
                          isPasswordHidden ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                        ),
                      ),
                    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
                    
                    const Gap(AppDimensions.md),
                    
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
                      prefixIcon: const Icon(Icons.lock_clock_outlined),
                      suffixIcon: IconButton(
                        onPressed: () {
                          ref
                              .read(confirmPasswordVisibilityProvider.notifier)
                              .toggle();
                        },
                        icon: Icon(
                          isConfirmPasswordHidden
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                        ),
                      ),
                    ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.1),
                    
                    const Gap(AppDimensions.xxl),
                    
                    AppButton(
                      text: AppStrings.register,
                      isLoading: authState.isLoading,
                      onPressed: () {
                        if (registerFormController.validate()) {
                          ref.read(authControllerProvider.notifier).register(
                                name: registerFormController.nameController.text.trim(),
                                email:
                                    registerFormController.emailController.text.trim(),
                                password: registerFormController
                                    .confirmPasswordController.text
                                    .trim(),
                              );
                        }
                      },
                    ).animate().fadeIn(delay: 800.ms).scale(),
                    
                    const Gap(AppDimensions.xl),
                    
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: theme.textTheme.bodyMedium,
                          children: [
                            const TextSpan(text: AppStrings.alreadyHaveAccount),
                            TextSpan(
                              text: ' ${AppStrings.login}',
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.pop();
                                },
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(delay: 900.ms),
                    
                    const Gap(AppDimensions.xxl),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
