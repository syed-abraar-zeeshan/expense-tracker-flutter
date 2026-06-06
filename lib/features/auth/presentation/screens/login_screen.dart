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
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
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
      if (next.isAuthenticated) {
        AppSnackbar.show(
          context,
          message: 'Welcome back!',
          type: SnackbarType.success,
        );
        context.go('/dashboard');
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient/Shapes
          Positioned(
                top: -100,
                right: -100,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withValues(
                          alpha: isDark ? 0.15 : 0.1,
                        ),
                        AppColors.transparent,
                      ],
                    ),
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 1000.ms)
              .scale(begin: const Offset(0.5, 0.5)),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.lg),
              child: Form(
                key: loginFormController.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(AppDimensions.xxl),

                    // Logo/Hero Area
                    Center(
                      child:
                          Container(
                            padding: const EdgeInsets.all(AppDimensions.md),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: AppColors.primaryGradient,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.account_balance_wallet_rounded,
                              size: 48,
                              color: Colors.white,
                            ),
                          ).animate().scale(
                            delay: 200.ms,
                            curve: Curves.easeOutBack,
                          ),
                    ),

                    const Gap(AppDimensions.xl),

                    Text(
                      'Welcome Back',
                      style: theme.textTheme.displaySmall,
                    ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.2),

                    const Gap(AppDimensions.xs),

                    Text(
                      AppStrings.trackExpensesSmarter,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.2),

                    const Gap(AppDimensions.xl),
                    AppTextField(
                      controller: loginFormController.emailController,
                      labelText: AppStrings.email,
                      hintText: AppStrings.enterEmail,
                      keyboardType: TextInputType.emailAddress,
                      validator: AppValidators.email,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),

                    const Gap(AppDimensions.lg),

                    AppTextField(
                      controller: loginFormController.passwordController,
                      labelText: AppStrings.password,
                      hintText: AppStrings.enterPassword,
                      validator: AppValidators.password,
                      obscureText: isPasswordHidden,
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        onPressed: () {
                          ref
                              .read(passwordVisibilityProvider.notifier)
                              .toggle();
                        },
                        icon: Icon(
                          isPasswordHidden
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                        ),
                      ),
                    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),

                    const Gap(AppDimensions.xs),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => context.push('/forgot-password'),
                        child: const Text(AppStrings.forgotPassword),
                      ),
                    ).animate().fadeIn(delay: 700.ms),

                    const Gap(AppDimensions.xl),

                    AppButton(
                      text: AppStrings.login,
                      isLoading: authState.isLoading,
                      onPressed: () {
                        if (loginFormController.validate()) {
                          ref
                              .read(authControllerProvider.notifier)
                              .login(
                                email: loginFormController.emailController.text
                                    .trim(),
                                password: loginFormController
                                    .passwordController
                                    .text
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
                            const TextSpan(text: AppStrings.dontHaveAccount),
                            TextSpan(
                              text: ' ${AppStrings.register}',
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.push('/register');
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
