import 'package:expense_flow/core/constants/app_strings.dart';
import 'package:expense_flow/core/constants/path_constants.dart';
import 'package:expense_flow/core/utils/app_snackbar.dart';
import 'package:expense_flow/core/utils/validation_utils.dart';
import 'package:expense_flow/features/auth/presentation/providers/auth_provider.dart';
import 'package:expense_flow/features/auth/presentation/widgets/auth_button.dart';
import 'package:expense_flow/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _register(WidgetRef ref, BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    await ref
        .read(authProvider.notifier)
        .register(
          _nameController.text.trim(),
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;

    ref.listen(authProvider, (previous, next) {
      if (next.error != null) {
        AppSnackbar.showError(context, next.error!);
      } else if (next.user != null && next.error == null) {
        AppSnackbar.showSuccess(context, 'Account created successfully!');
        context.go(PathConstants.login);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(48),
                _buildHeader(context)
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: -0.2, end: 0),
                const Gap(40),
                AuthTextField(
                  hint: AppStrings.nameHint,
                  icon: Icons.person_outline_rounded,
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  autofillHints: const [AutofillHints.name],
                  validator: ValidationUtils.validateName,
                ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1, end: 0),
                const Gap(16),
                AuthTextField(
                  hint: AppStrings.emailHint,
                  icon: Icons.mail_outline_rounded,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  validator: ValidationUtils.validateEmail,
                ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1, end: 0),
                const Gap(16),
                AuthTextField(
                  hint: AppStrings.passwordHint,
                  icon: Icons.lock_outline_rounded,
                  controller: _passwordController,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.newPassword],
                  onFieldSubmitted: (_) => _register(ref, context),
                  validator: ValidationUtils.validatePassword,
                ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.1, end: 0),
                const Gap(32),
                AuthButton(
                  label: AppStrings.createAccount,
                  isLoading: isLoading,
                  onPressed: () => _register(ref, context),
                ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),
                const Gap(24),
                _buildLoginLink(context).animate().fadeIn(delay: 600.ms),
                const Gap(32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.account_balance_wallet_rounded,
            color: Colors.white,
            size: 36,
          ),
        ),
        const Gap(16),
        const Text(
          AppStrings.registerTitle,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
        const Gap(8),
        Text(
          AppStrings.registerSubtitle,
          style: TextStyle(fontSize: 14, color: Colors.grey[500]),
        ),
      ],
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.alreadyHaveAccount,
          style: TextStyle(color: Colors.grey[500], fontSize: 14),
        ),
        GestureDetector(
          onTap: () => context.go(PathConstants.login),
          child: Text(
            AppStrings.signIn,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
