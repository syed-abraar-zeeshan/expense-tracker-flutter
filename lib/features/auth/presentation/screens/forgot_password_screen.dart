import 'package:expense_flow/core/constants/app_strings.dart';
import 'package:expense_flow/core/theme/app_dimensions.dart';
import 'package:expense_flow/core/utils/app_validators.dart';
import 'package:expense_flow/core/widgets/app_button.dart';
import 'package:expense_flow/core/widgets/app_snackbar.dart';
import 'package:expense_flow/core/widgets/app_text_field.dart';
import 'package:expense_flow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:expense_flow/features/auth/presentation/forms/forgot_password_form_controller.dart';
import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  late final ForgotPasswordFormController formController;

  @override
  void initState() {
    super.initState();
    formController = ForgotPasswordFormController();
  }

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            top: -50,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accent.withValues(alpha: isDark ? 0.15 : 0.1),
                    AppColors.transparent,
                  ],
                ),
              ),
            ),
          ).animate().fadeIn(duration: 1000.ms).scale(),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.lg),
              child: authState.isPasswordResetSent 
                  ? _buildSuccessUI(theme) 
                  : _buildFormUI(theme, authState),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormUI(ThemeData theme, dynamic authState) {
    return Form(
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
            AppStrings.resetLinkDescription,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.textTheme.bodySmall?.color,
            ),
          ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.2),
          
          const Gap(AppDimensions.massive),
          
          AppTextField(
            controller: formController.emailController,
            labelText: AppStrings.email,
            hintText: AppStrings.enterEmail,
            keyboardType: TextInputType.emailAddress,
            validator: AppValidators.email,
            prefixIcon: const Icon(Icons.email_outlined),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
          
          const Gap(AppDimensions.xxl),
          
          AppButton(
            text: AppStrings.sendResetLink,
            isLoading: authState.isLoading,
            onPressed: () {
              if (formController.validate()) {
                ref.read(authControllerProvider.notifier).forgotPassword(
                  email: formController.emailController.text.trim(),
                );
              }
            },
          ).animate().fadeIn(delay: 500.ms).scale(),
        ],
      ),
    );
  }

  Widget _buildSuccessUI(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Gap(AppDimensions.massive),
        Center(
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.xl),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.success.withValues(alpha: 0.1),
            ),
            child: const Icon(
              Icons.mark_email_read_rounded,
              size: 80,
              color: AppColors.success,
            ),
          ).animate().scale(curve: Curves.easeOutBack),
        ),
        
        const Gap(AppDimensions.xl),
        
        Text(
          AppStrings.checkYourEmail,
          style: theme.textTheme.headlineMedium,
        ).animate().fadeIn(delay: 200.ms),
        
        const Gap(AppDimensions.md),
        
        Text(
          '${AppStrings.resetLinkSentTo}\n${formController.emailController.text}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.textTheme.bodySmall?.color,
          ),
        ).animate().fadeIn(delay: 300.ms),
        
        const Gap(AppDimensions.massive),
        
        AppButton(
          text: AppStrings.backToLogin,
          useGradient: false,
          backgroundColor: theme.colorScheme.surface,
          foregroundColor: theme.colorScheme.onSurface,
          onPressed: () => context.pop(),
        ).animate().fadeIn(delay: 400.ms),
      ],
    );
  }
}
