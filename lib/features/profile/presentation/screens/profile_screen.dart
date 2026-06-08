import 'package:expense_flow/core/constants/app_strings.dart';
import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:expense_flow/core/theme/app_dimensions.dart';
import 'package:expense_flow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:expense_flow/features/settings/presentation/controllers/currency_controller.dart';
import 'package:expense_flow/features/settings/presentation/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _showCurrencySelector(BuildContext context, WidgetRef ref, ThemeData theme) {
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final currentCurrency = ref.watch(currencyControllerProvider);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.dividerColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const Gap(AppDimensions.xl),
                Text(
                  'Select Currency',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const Gap(AppDimensions.md),
                ...availableCurrencies.map((currency) {
                  final isSelected = currency.code == currentCurrency.code;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : theme.dividerColor.withValues(alpha: 0.05),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(currency.symbol, style: theme.textTheme.titleLarge?.copyWith(color: isSelected ? AppColors.primary : null)),
                    ),
                    title: Text(currency.name, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400)),
                    subtitle: Text(currency.code, style: theme.textTheme.bodySmall),
                    trailing: isSelected ? const Icon(Icons.check_circle_rounded, color: AppColors.primary) : null,
                    onTap: () {
                      ref.read(currencyControllerProvider.notifier).setCurrency(currency);
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final currentCurrency = ref.watch(currencyControllerProvider);
    final user = authState.user;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 1. Profile Header Card
          SliverAppBar(
            expandedHeight: 280,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: theme.scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeaderCard(context, user, theme),
              stretchModes: const [StretchMode.zoomBackground],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit_note_rounded, size: 28),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(AppDimensions.xl),
                  
                  // 2. Statistics Section
                  _buildStatisticsSection(theme, isDark),
                  
                  const Gap(AppDimensions.xl),
                  
                  // 3. Settings Section
                  _buildSectionHeader(theme, 'Account Settings'),
                  const Gap(AppDimensions.md),
                  _buildSettingsGroup(theme, isDark, [
                    _buildSettingTile(
                      theme,
                      isDark,
                      Icons.dark_mode_rounded,
                      'Dark Mode',
                      trailing: Switch.adaptive(
                        value: ref.watch(themeControllerProvider) == ThemeMode.dark,
                        onChanged: (value) {
                          ref.read(themeControllerProvider.notifier).toggleTheme(value);
                        },
                        activeColor: AppColors.primary,
                      ),
                    ),
                    _buildSettingTile(theme, isDark, Icons.notifications_active_rounded, 'Notifications'),
                    _buildSettingTile(
                      theme, 
                      isDark, 
                      Icons.currency_exchange_rounded, 
                      'Currency', 
                      trailing: Text('${currentCurrency.code} (${currentCurrency.symbol})', style: const TextStyle(fontWeight: FontWeight.w600)),
                      onTap: () => _showCurrencySelector(context, ref, theme),
                    ),
                    _buildSettingTile(theme, isDark, Icons.security_rounded, 'Security'),
                  ]),

                  
                  const Gap(AppDimensions.xl),
                  
                  // 4. App Section
                  _buildSectionHeader(theme, 'App Information'),
                  const Gap(AppDimensions.md),
                  _buildSettingsGroup(theme, isDark, [
                    _buildSettingTile(theme, isDark, Icons.info_outline_rounded, 'About App'),
                    _buildSettingTile(theme, isDark, Icons.privacy_tip_outlined, 'Privacy Policy'),
                    _buildSettingTile(theme, isDark, Icons.description_outlined, 'Terms & Conditions'),
                  ]),
                  
                  const Gap(AppDimensions.xxl),
                  
                  // 5. Logout Section
                  _buildLogoutButton(context, ref, theme),
                  
                  const Gap(AppDimensions.massive),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, dynamic user, ThemeData theme) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: -50,
            top: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(20),
                Hero(
                  tag: 'profile_avatar',
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white24,
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Text(
                        user?.name.substring(0, 1).toUpperCase() ?? 'G',
                        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
                const Gap(AppDimensions.md),
                Text(
                  user?.name ?? AppStrings.guestUser,
                  style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                ),
                Text(
                  user?.email ?? 'guest@expenseflow.com',
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection(ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(theme, '124', 'Transactions'),
          Container(width: 1, height: 40, color: theme.dividerColor.withValues(alpha: 0.1)),
          _buildStatItem(theme, '\$12k', 'Income'),
          Container(width: 1, height: 40, color: theme.dividerColor.withValues(alpha: 0.1)),
          _buildStatItem(theme, '\$8k', 'Expenses'),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }

  Widget _buildStatItem(ThemeData theme, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, color: AppColors.primary),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
    );
  }

  Widget _buildSettingsGroup(ThemeData theme, bool isDark, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.05)),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingTile(ThemeData theme, bool isDark, IconData icon, String title, {Widget? trailing, VoidCallback? onTap}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
      trailing: trailing ?? const Icon(Icons.chevron_right_rounded, size: 20),
      onTap: onTap ?? (trailing == null ? () {} : null),
    );
  }

  Widget _buildLogoutButton(BuildContext context, WidgetRef ref, ThemeData theme) {
    return AppButton(
      text: 'Logout',
      onPressed: () => _showLogoutDialog(context, ref),
      backgroundColor: AppColors.error.withValues(alpha: 0.1),
      foregroundColor: AppColors.error,
      useGradient: false,
      icon: const Icon(Icons.logout_rounded, color: AppColors.error),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(authControllerProvider.notifier).logout();
              if (context.mounted) {
                context.go('/');
              }
            },
            child: const Text('Logout', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool useGradient;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.useGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: (useGradient && onPressed != null)
            ? const LinearGradient(colors: AppColors.primaryGradient)
            : null,
        color: backgroundColor ?? (onPressed == null ? theme.disabledColor : null),
        boxShadow: [
          if (useGradient && onPressed != null)
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: foregroundColor ?? Colors.white,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: isLoading
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[icon!, const Gap(8)],
                  Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
      ),
    );
  }
}
