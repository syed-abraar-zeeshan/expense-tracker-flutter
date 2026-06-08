import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:expense_flow/core/theme/app_dimensions.dart';
import 'package:expense_flow/core/utils/app_currency_formatter.dart';
import 'package:expense_flow/features/settings/presentation/controllers/currency_controller.dart';
import 'package:expense_flow/features/categories/domain/entities/category_entity.dart';
import 'package:expense_flow/features/categories/presentation/controllers/categories_controller.dart';
import 'package:expense_flow/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  int _touchedIndex = -1;
  String _selectedType = 'expense';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(categoriesControllerProvider.notifier).getCategories();
    });
  }

  // Helper to parse hex colors like #FF5D5FEF or FF5D5FEF
  Color _parseColor(String colorString) {
    try {
      String hexString = colorString.replaceAll('#', '');
      if (hexString.length == 6) {
        hexString = 'FF$hexString';
      }
      return Color(int.parse(hexString, radix: 16));
    } catch (e) {
      return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesState = ref.watch(categoriesControllerProvider);
    final dashboardState = ref.watch(dashboardControllerProvider);
    final currentCurrency = ref.watch(currencyControllerProvider).selectedCurrency;
    final theme = Theme.of(context);

    final categories = categoriesState.categories;
    final transactions = dashboardState.dashboard?.recentTransactions ?? [];

    // Calculate stats
    double totalAmount = 0;
    Map<String, double> categorySpending = {};
    Map<String, int> categoryCounts = {};

    for (final tx in transactions) {
      if (tx.type.toLowerCase() == _selectedType) {
        final amount = tx.amount.abs();
        totalAmount += amount;
        categorySpending[tx.category.id] =
            (categorySpending[tx.category.id] ?? 0) + amount;
        categoryCounts[tx.category.id] =
            (categoryCounts[tx.category.id] ?? 0) + 1;
      }
    }

    // Sort categories by spending for most used
    final sortedCategories =
        categories.where((c) => categorySpending.containsKey(c.id)).toList()
          ..sort(
            (a, b) => (categorySpending[b.id] ?? 0).compareTo(
              categorySpending[a.id] ?? 0,
            ),
          );

    final mostUsed = sortedCategories.isNotEmpty
        ? sortedCategories.first
        : null;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Categories',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(categoriesControllerProvider.notifier).getCategories();
          await ref.read(dashboardControllerProvider.notifier).getDashboard();
        },
        child: categoriesState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : categories.isEmpty
            ? _buildEmptyState(theme)
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(AppDimensions.md),

                    // Type Toggle
                    Center(
                      child: SegmentedButton<String>(
                        segments: const [
                          ButtonSegment<String>(
                            value: 'expense',
                            label: Text('Expenses'),
                            icon: Icon(Icons.remove_circle_outline),
                          ),
                          ButtonSegment<String>(
                            value: 'income',
                            label: Text('Income'),
                            icon: Icon(Icons.add_circle_outline),
                          ),
                        ],
                        selected: {_selectedType},
                        onSelectionChanged: (Set<String> newSelection) {
                          setState(() {
                            _selectedType = newSelection.first;
                            _touchedIndex = -1;
                          });
                        },
                        style: SegmentedButton.styleFrom(
                          backgroundColor: theme.colorScheme.surface,
                          selectedBackgroundColor: _selectedType == 'expense'
                              ? AppColors.error.withValues(alpha: 0.1)
                              : AppColors.success.withValues(alpha: 0.1),
                          selectedForegroundColor: _selectedType == 'expense'
                              ? AppColors.error
                              : AppColors.success,
                          side: BorderSide(
                            color: theme.dividerColor.withValues(alpha: 0.1),
                          ),
                        ),
                      ),
                    ).animate().fadeIn().slideY(begin: -0.1),

                    const Gap(AppDimensions.lg),

                    // 1. Overview
                    _buildOverviewCard(
                      totalAmount,
                      mostUsed,
                      theme,
                      currentCurrency.symbol,
                      currentCurrency.conversionRate,
                      _selectedType,
                    ),

                    const Gap(AppDimensions.xl),

                    // 2. Chart
                    if (totalAmount > 0) ...[
                      Text(
                        _selectedType == 'expense' 
                          ? 'Spending Distribution'
                          : 'Income Distribution',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Gap(AppDimensions.md),
                      _buildChartSection(
                        sortedCategories,
                        categorySpending,
                        totalAmount,
                        theme,
                      ),
                      const Gap(AppDimensions.xl),
                    ],

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All Categories',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '${categories.length} Total',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const Gap(AppDimensions.md),

                    // 3. Categories List
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categories.length,
                      separatorBuilder: (_, _) => const Gap(AppDimensions.sm),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final spent = categorySpending[category.id] ?? 0;
                        final count = categoryCounts[category.id] ?? 0;
                        final percentage = totalAmount > 0
                            ? (spent / totalAmount) * 100
                            : 0;

                        return _buildCategoryCard(
                          category,
                          spent,
                          count,
                          percentage.toDouble(),
                          theme,
                          index,
                          currentCurrency.symbol,
                          currentCurrency.conversionRate,
                        );
                      },
                    ),

                    const Gap(AppDimensions.xxl),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildOverviewCard(
    double totalAmount,
    CategoryEntity? mostUsed,
    ThemeData theme,
    String symbol,
    double conversionRate,
    String selectedType,
  ) {
    final isExpense = selectedType == 'expense';

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isExpense ? 'Total Expenses' : 'Total Income',
                style: theme.textTheme.bodySmall,
              ),
              const Gap(4),
              Text(
                AppCurrencyFormatter.format(
                  totalAmount,
                  symbol: symbol,
                  conversionRate: conversionRate,
                ),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isExpense ? AppColors.error : AppColors.success,
                ),
              ),
            ],
          ),
          Container(
            width: 1,
            height: 40,
            color: theme.dividerColor.withValues(alpha: 0.1),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Most Used', style: theme.textTheme.bodySmall),
              const Gap(4),
              Row(
                children: [
                  if (mostUsed != null) ...[
                    Text(mostUsed.icon, style: const TextStyle(fontSize: 16)),
                    const Gap(6),
                    Text(
                      mostUsed.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ] else
                    Text(
                      'N/A',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.1);
  }

  Widget _buildChartSection(
    List<CategoryEntity> sortedCategories,
    Map<String, double> categorySpending,
    double totalAmount,
    ThemeData theme,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        _touchedIndex = -1;
                        return;
                      }
                      _touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(show: false),
                sectionsSpace: 2,
                centerSpaceRadius: 60,
                sections: List.generate(sortedCategories.length, (i) {
                  final isTouched = i == _touchedIndex;
                  final radius = isTouched ? 35.0 : 30.0;
                  final category = sortedCategories[i];
                  final value = categorySpending[category.id] ?? 0;
                  final percentage = (value / totalAmount) * 100;
                  final color = _parseColor(category.color);

                  return PieChartSectionData(
                    color: color,
                    value: value,
                    title: isTouched ? '${percentage.toStringAsFixed(1)}%' : '',
                    radius: radius,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    badgeWidget: isTouched
                        ? Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.black26, blurRadius: 4),
                              ],
                            ),
                            child: Text(
                              category.icon,
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        : null,
                    badgePositionPercentageOffset: 1.2,
                  );
                }),
              ),
            ),
          ),
          const Gap(AppDimensions.lg),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: sortedCategories.map((c) {
              final color = _parseColor(c.color);
              final percentage =
                  ((categorySpending[c.id] ?? 0) / totalAmount) * 100;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Gap(6),
                  Text(
                    '${c.name} ${percentage.toStringAsFixed(0)}%',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildCategoryCard(
    CategoryEntity category,
    double spent,
    int count,
    double percentage,
    ThemeData theme,
    int index,
    String symbol,
    double conversionRate,
  ) {
    final color = _parseColor(category.color);

    return InkWell(
      onTap: () {
        // Navigation placeholder for detail view
        // context.push('/category-detail', extra: category.id);
      },
      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.md),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          border: Border.all(color: theme.dividerColor.withValues(alpha: 0.05)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(category.icon, style: const TextStyle(fontSize: 24)),
            ),
            const Gap(AppDimensions.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Gap(4),
                  Text('$count Transactions', style: theme.textTheme.bodySmall),
                  const Gap(8),
                  LinearProgressIndicator(
                    value: percentage / 100,
                    backgroundColor: theme.dividerColor.withValues(alpha: 0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 4,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ],
              ),
            ),
            const Gap(AppDimensions.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppCurrencyFormatter.format(
                    spent,
                    symbol: symbol,
                    conversionRate: conversionRate,
                  ),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Gap(4),
                Text(
                  '${percentage.toStringAsFixed(1)}%',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.05);
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(100),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.dividerColor.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.category_outlined,
              size: 64,
              color: theme.disabledColor,
            ),
          ),
          const Gap(AppDimensions.lg),
          Text(
            'No categories available',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(8),
          Text(
            'Check your connection or add categories.',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ).animate().fadeIn().scale(begin: const Offset(0.9, 0.9)),
    );
  }
}
