import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:expense_flow/core/theme/app_dimensions.dart';
import 'package:expense_flow/core/utils/app_currency_formatter.dart';
import 'package:expense_flow/features/dashboard/domain/enities/transaction_entity.dart';
import 'package:expense_flow/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:expense_flow/features/settings/presentation/controllers/currency_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ExpenseListScreen extends ConsumerStatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  ConsumerState<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends ConsumerState<ExpenseListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All'; // All, Income, Expense

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardControllerProvider);
    final currentCurrency = ref.watch(currencyControllerProvider);
    final theme = Theme.of(context);

    final allTransactions = dashboardState.dashboard?.recentTransactions ?? [];

    // UI-level filtering
    final filteredTransactions = allTransactions.where((tx) {
      final matchesSearch =
          tx.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          tx.category.name.toLowerCase().contains(_searchQuery.toLowerCase());

      final isExpense = tx.type.toLowerCase() == 'expense';
      final isIncome = tx.type.toLowerCase() == 'income';

      final matchesType =
          _selectedFilter == 'All' ||
          (_selectedFilter == 'Income' && isIncome) ||
          (_selectedFilter == 'Expense' && isExpense);

      return matchesSearch && matchesType;
    }).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Transactions',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(dashboardControllerProvider.notifier).getDashboard(),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.lg,
                ),
                child: Column(
                  children: [
                    const Gap(AppDimensions.md),

                    // 1. Header (Balance Summary)
                    _buildSummaryHeader(dashboardState.dashboard, theme, currentCurrency.symbol, currentCurrency.conversionRate),

                    const Gap(AppDimensions.xl),

                    // 2. Search Bar
                    _buildSearchBar(theme),

                    const Gap(AppDimensions.lg),

                    // 3. Filters
                    _buildFilters(theme),

                    const Gap(AppDimensions.xl),
                  ],
                ),
              ),
            ),

            // 4. Transaction List
            if (dashboardState.isLoading)
              const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child:
                        CircularProgressIndicator(), // Skeleton can be added here
                  ),
                ),
              )
            else if (filteredTransactions.isEmpty)
              SliverToBoxAdapter(child: _buildEmptyState(theme))
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.lg,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildTransactionCard(
                      filteredTransactions[index],
                      theme,
                      index,
                      currentCurrency.symbol,
                      currentCurrency.conversionRate,
                    ),
                    childCount: filteredTransactions.length,
                  ),
                ),
              ),

            const SliverToBoxAdapter(child: Gap(100)),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryHeader(dynamic dashboard, ThemeData theme, String symbol, double conversionRate) {
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
          _buildSummaryColumn(
            'Income',
            dashboard?.totalIncome ?? 0.0,
            AppColors.success,
            theme,
            symbol,
            conversionRate,
          ),
          Container(
            width: 1,
            height: 40,
            color: theme.dividerColor.withValues(alpha: 0.1),
          ),
          _buildSummaryColumn(
            'Expenses',
            dashboard?.totalExpense ?? 0.0,
            AppColors.error,
            theme,
            symbol,
            conversionRate,
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.1);
  }

  Widget _buildSummaryColumn(
    String label,
    double amount,
    Color color,
    ThemeData theme,
    String symbol,
    double conversionRate,
  ) {
    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
        ),
        const Gap(4),
        Text(
          AppCurrencyFormatter.format(amount, symbol: symbol, conversionRate: conversionRate),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    return TextField(
      controller: _searchController,
      onChanged: (val) => setState(() => _searchQuery = val),
      decoration: InputDecoration(
        hintText: 'Search transactions...',
        prefixIcon: const Icon(Icons.search_rounded),
        filled: true,
        fillColor: theme.colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          borderSide: BorderSide.none,
        ),
      ),
    ).animate().fadeIn(delay: 100.ms);
  }

  Widget _buildFilters(ThemeData theme) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ['All', 'Income', 'Expense'].map((filter) {
          final isSelected = _selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() => _selectedFilter = filter);
                }
              },
              backgroundColor: theme.colorScheme.surface,
              selectedColor: AppColors.primary,
              labelStyle: theme.textTheme.bodySmall?.copyWith(
                color: isSelected
                    ? Colors.white
                    : theme.textTheme.bodyLarge?.color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.primary
                      : theme.dividerColor.withValues(alpha: 0.1),
                ),
              ),
              showCheckmark: false,
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildTransactionCard(
    TransactionEntity tx,
    ThemeData theme,
    int index,
    String symbol,
    double conversionRate,
  ) {
    final isIncome = tx.type.toLowerCase() == 'income';
    final color = isIncome ? AppColors.success : AppColors.error;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.md),
      child: Dismissible(
        key: Key(tx.id),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text("Confirm Delete"),
                content: const Text(
                  "Are you sure you wish to delete this transaction?",
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                        color: AppColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: AppColors.error,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
        ),
        onDismissed: (direction) {
          // TODO: Actually delete via controller here
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Transaction deleted (UI Simulated)'),
              backgroundColor: AppColors.error,
            ),
          );
        },
        child: InkWell(
          onTap: () => context.push('/edit-expense', extra: tx),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.md),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: 0.05),
              ),
            ),
            child: Row(
              children: [
                // padding: const EdgeInsets.all(12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isIncome
                        ? Icons.account_balance_wallet_outlined
                        : Icons.shopping_bag_outlined,
                    color: color,
                    size: 24,
                  ),
                ),
                const Gap(AppDimensions.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        '${tx.category.name} • ${DateFormat.yMMMd().format(tx.date)}',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Text(
                  '${isIncome ? '+' : '-'} ${AppCurrencyFormatter.format(tx.amount.abs(), symbol: symbol, conversionRate: conversionRate)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.05),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(40),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.dividerColor.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 64,
              color: theme.disabledColor,
            ),
          ),
          const Gap(AppDimensions.lg),
          Text(
            'No transactions found',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(8),
          Text(
            'Try adjusting your filters or search query.',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ).animate().fadeIn().scale(begin: const Offset(0.9, 0.9)),
    );
  }
}
