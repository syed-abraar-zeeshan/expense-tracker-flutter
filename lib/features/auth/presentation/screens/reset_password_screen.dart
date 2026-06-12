import 'package:expense_flow/core/constants/app_strings.dart';
import 'package:expense_flow/core/theme/app_dimensions.dart';
import 'package:expense_flow/core/utils/app_validators.dart';
import 'package:expense_flow/core/widgets/app_button.dart';
import 'package:expense_flow/core/widgets/app_snackbar.dart';
import 'package:expense_flow/core/widgets/app_text_field.dart';
import 'package:expense_flow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:expense_flow/features/auth/presentation/forms/reset_password_form_controller.dart';
import 'package:expense_flow/features/auth/presentation/providers/reset_password_provider.dart';
import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  final String email;
  final String token;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.token,
  });

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  late final ResetPasswordFormController formController;

  @override
  void initState() {
    super.initState();
    formController = ResetPasswordFormController();
  }

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isPasswordHidden = ref.watch(resetPasswordVisibilityProvider);
    final isConfirmPasswordHidden = ref.watch(resetConfirmPasswordVisibilityProvider);
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
      if (next.isPasswordResetSuccess) {
        AppSnackbar.show(
          context,
          message: AppStrings.passwordResetSuccess,
          type: SnackbarType.success,
        );
        context.go('/'); // Back to login
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
          // Background Shape
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
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
          ).animate().fadeIn(duration: 1000.ms).scale(),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.lg),
              child: Form(
                key: formController.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(AppDimensions.md),
                    Text(
                      AppStrings.resetPassword,
                      style: theme.textTheme.displaySmall,
                    ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
                    
                    const Gap(AppDimensions.xs),
                    
                    Text(
                      AppStrings.enterNewPassword,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.2),
                    
                    const Gap(AppDimensions.massive),
                    
                    AppTextField(
                      controller: formController.passwordController,
                      labelText: AppStrings.newPassword,
                      hintText: AppStrings.enterPassword,
                      validator: AppValidators.password,
                      obscureText: isPasswordHidden,
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        onPressed: () {
                          ref.read(resetPasswordVisibilityProvider.notifier).toggle();
                        },
                        icon: Icon(
                          isPasswordHidden ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                        ),
                      ),
                    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
                    
                    const Gap(AppDimensions.md),
                    
                    AppTextField(
                      controller: formController.confirmPasswordController,
                      labelText: AppStrings.confirmNewPassword,
                      hintText: AppStrings.confirmPassword,
                      validator: (value) {
                        return AppValidators.confirmPassword(
                          value,
                          formController.passwordController.text,
                        );
                      },
                      obscureText: isConfirmPasswordHidden,
                      prefixIcon: const Icon(Icons.lock_clock_outlined),
                      suffixIcon: IconButton(
                        onPressed: () {
                          ref.read(resetConfirmPasswordVisibilityProvider.notifier).toggle();
                        },
                        icon: Icon(
                          isConfirmPasswordHidden ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                        ),
                      ),
                    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),
                    
                    const Gap(AppDimensions.xxl),
                    
                    AppButton(
                      text: AppStrings.resetPassword,
                      isLoading: authState.isLoading,
                      onPressed: () {
                        if (formController.validate()) {
                          ref.read(authControllerProvider.notifier).resetPassword(
                            email: widget.email,
                            password: formController.passwordController.text.trim(),
                            token: widget.token,
                          );
                        }
                      },
                    ).animate().fadeIn(delay: 600.ms).scale(),
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
