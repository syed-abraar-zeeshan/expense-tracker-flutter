import 'package:expense_flow/core/constants/app_strings.dart';
import 'package:expense_flow/core/theme/app_dimensions.dart';
import 'package:expense_flow/core/utils/app_validators.dart';
import 'package:expense_flow/core/widgets/app_button.dart';
import 'package:expense_flow/core/widgets/app_text_field.dart';
import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSuccess = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleResetPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isSuccess = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.lg),
              child: _isSuccess ? _buildSuccessUI(theme) : _buildFormUI(theme),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormUI(ThemeData theme) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(AppDimensions.md),
          Text(
            'Reset Password',
            style: theme.textTheme.displaySmall,
          ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
          
          const Gap(AppDimensions.xs),
          
          Text(
            'Enter your email address and we will send you a link to reset your password.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.textTheme.bodySmall?.color,
            ),
          ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.2),
          
          const Gap(AppDimensions.massive),
          
          AppTextField(
            controller: _emailController,
            labelText: AppStrings.email,
            hintText: AppStrings.enterEmail,
            keyboardType: TextInputType.emailAddress,
            validator: AppValidators.email,
            prefixIcon: const Icon(Icons.email_outlined),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
          
          const Gap(AppDimensions.xxl),
          
          AppButton(
            text: 'Send Reset Link',
            isLoading: _isLoading,
            onPressed: _handleResetPassword,
          ).animate().fadeIn(delay: 500.ms).scale(),
        ],
      ),
    );
  }

  Widget _buildSuccessUI(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
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
        
        const Gap(AppDimensions.xl),
        
        Text(
          'Check Your Email',
          style: theme.textTheme.headlineMedium,
        ).animate().fadeIn(delay: 200.ms),
        
        const Gap(AppDimensions.md),
        
        Text(
          'We have sent a password reset link to\n${_emailController.text}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.textTheme.bodySmall?.color,
          ),
        ).animate().fadeIn(delay: 300.ms),
        
        const Gap(AppDimensions.massive),
        
        AppButton(
          text: 'Back to Login',
          useGradient: false,
          backgroundColor: theme.colorScheme.surface,
          foregroundColor: theme.colorScheme.onSurface,
          onPressed: () => context.pop(),
        ).animate().fadeIn(delay: 400.ms),
      ],
    );
  }
}
