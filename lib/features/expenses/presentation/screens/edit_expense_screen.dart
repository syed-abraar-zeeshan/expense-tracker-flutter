import 'dart:io';

import 'package:expense_flow/core/theme/app_colors.dart';
import 'package:expense_flow/core/theme/app_dimensions.dart';
import 'package:expense_flow/core/widgets/app_button.dart';
import 'package:expense_flow/core/widgets/app_snackbar.dart';
import 'package:expense_flow/features/settings/presentation/controllers/currency_controller.dart';
import 'package:expense_flow/features/categories/presentation/controllers/categories_controller.dart';
import 'package:expense_flow/features/dashboard/domain/enities/transaction_entity.dart';
import 'package:expense_flow/features/expenses/presentation/controllers/expense_controller.dart';
import 'package:expense_flow/features/expenses/presentation/form/expense_form_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EditExpenseScreen extends ConsumerStatefulWidget {
  final TransactionEntity transaction;

  const EditExpenseScreen({super.key, required this.transaction});

  @override
  ConsumerState<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends ConsumerState<EditExpenseScreen> {
  final formController = ExpenseFormController();
  final FocusNode _amountFocusNode = FocusNode();
  bool _isAmountFocused = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(categoriesControllerProvider.notifier).getCategories();
    });

    _amountFocusNode.addListener(() {
      setState(() {
        _isAmountFocused = _amountFocusNode.hasFocus;
      });
    });

    // Pre-fill existing data
    formController.titleController.text = widget.transaction.title;
    formController.amountController.text = widget.transaction.amount
        .abs()
        .toString();
    formController.selectedCategoryId = widget.transaction.category.id;
    formController.selectedType =
        widget.transaction.type.toLowerCase() == 'income'
        ? 'income'
        : 'expense';
    formController.selectedDate = widget.transaction.date;
    formController.dateController.text = DateFormat.yMMMd().format(
      widget.transaction.date,
    );
    // Assuming note is empty in the entity since it's not present, we skip or set if it exists
  }

  @override
  void dispose() {
    _amountFocusNode.dispose();
    formController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    if (Platform.isIOS) {
      DateTime selectedDate = formController.selectedDate;

      showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return Container(
            height: 300,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                    child: const Text('Done'),
                    onPressed: () {
                      formController.selectedDate = selectedDate;
                      formController.dateController.text = DateFormat.yMMMd()
                          .format(selectedDate);
                      Navigator.pop(context);
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: selectedDate,
                    onDateTimeChanged: (date) {
                      selectedDate = date;
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      final pickedDate = await showDatePicker(
        context: context,
        initialDate: formController.selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
      );

      if (pickedDate != null) {
        formController.selectedDate = pickedDate;
        formController.dateController.text = DateFormat.yMMMd().format(
          pickedDate,
        );
        setState(() {});
      }
    }
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Transaction'),
        content: const Text(
          'Are you sure you want to delete this transaction? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Wire up actual delete logic to controller when backend is ready
              AppSnackbar.show(
                context,
                message: 'Transaction deleted (UI Simulated)',
                type: SnackbarType.success,
              );
              context.pop();
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                color: AppColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoriesState = ref.watch(categoriesControllerProvider);
    final expenseState = ref.watch(expenseControllerProvider);
    final currentCurrency = ref.watch(currencyControllerProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    ref.listen(expenseControllerProvider, (previous, next) {
      if (next.isSuccess) {
        AppSnackbar.show(
          context,
          message: 'Transaction updated successfully',
          type: SnackbarType.success,
        );
        context.pop();
      }

      if (next.errorMessage != null) {
        AppSnackbar.show(
          context,
          message: next.errorMessage!,
          type: SnackbarType.error,
        );
        ref.read(expenseControllerProvider.notifier).clearError();
      }
    });

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 1. Header
          SliverAppBar(
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => context.pop(),
            ),
            title: Text(
              'Edit Transaction',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.error,
                ),
                onPressed: _showDeleteConfirmation,
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(AppDimensions.lg),

                  // 4. Transaction Type (Segmented Control)
                  _buildTransactionTypeControl(theme),

                  const Gap(AppDimensions.xxl),

                  // 2. Amount Section
                  _buildAmountSection(theme, isDark, currentCurrency.symbol),

                  const Gap(AppDimensions.xxl),

                  // Title Input
                  _buildTitleSection(theme),

                  const Gap(AppDimensions.xl),

                  // 3. Category Selection
                  _buildCategorySelection(theme, categoriesState),

                  const Gap(AppDimensions.xl),

                  // 5. Date Picker
                  _buildDatePickerCard(theme),

                  const Gap(AppDimensions.xl),

                  // 6. Notes Section
                  _buildNotesSection(theme),

                  const Gap(AppDimensions.xxl),

                  // 7. Save Button
                  AppButton(
                    text: 'Update Transaction',
                    isLoading: expenseState.isLoading,
                    onPressed: () async {
                      if (formController.amountController.text.isEmpty ||
                          formController.titleController.text.isEmpty ||
                          formController.selectedCategoryId == null) {
                        AppSnackbar.show(
                          context,
                          message: 'Please fill in all required fields',
                          type: SnackbarType.error,
                        );
                        return;
                      }

                      // Since controller doesn't have an update method yet, we simulate or call create
                      // Ideally: ref.read(expenseControllerProvider.notifier).updateExpense(...)
                      AppSnackbar.show(
                        context,
                        message: 'Transaction updated (UI Simulated)',
                        type: SnackbarType.success,
                      );
                      context.pop();
                    },
                  ).animate().fadeIn().scale(delay: 500.ms),

                  const Gap(AppDimensions.massive),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTypeControl(ThemeData theme) {
    final isExpense = formController.selectedType == 'expense';

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () =>
                  setState(() => formController.selectedType = 'expense'),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isExpense ? AppColors.error : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Expense',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: isExpense
                        ? Colors.white
                        : theme.textTheme.bodyMedium?.color,
                    fontWeight: isExpense ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () =>
                  setState(() => formController.selectedType = 'income'),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !isExpense ? AppColors.success : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Income',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: !isExpense
                        ? Colors.white
                        : theme.textTheme.bodyMedium?.color,
                    fontWeight: !isExpense ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.1);
  }

  Widget _buildAmountSection(ThemeData theme, bool isDark, String symbol) {
    final isExpense = formController.selectedType == 'expense';
    final primaryColor = isExpense ? AppColors.error : AppColors.success;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: _isAmountFocused
            ? primaryColor.withValues(alpha: 0.05)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: _isAmountFocused
              ? primaryColor
              : theme.dividerColor.withValues(alpha: 0.05),
          width: _isAmountFocused ? 2 : 1,
        ),
        boxShadow: _isAmountFocused
            ? [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        children: [
          Text(
            'Amount',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: _isAmountFocused
                  ? primaryColor
                  : theme.textTheme.bodySmall?.color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                symbol,
                style: theme.textTheme.displayMedium?.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(8),
              IntrinsicWidth(
                child: TextField(
                  controller: formController.amountController,
                  focusNode: _amountFocusNode,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: theme.textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.w800,
                  ),
                  decoration: InputDecoration(
                    hintText: '0',
                    hintStyle: theme.textTheme.displayLarge?.copyWith(
                      color: theme.disabledColor.withValues(alpha: 0.3),
                      fontWeight: FontWeight.w800,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms).scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildTitleSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Title', style: theme.textTheme.titleSmall),
        const Gap(8),
        TextField(
          controller: formController.titleController,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: 'What was this for?',
            filled: true,
            fillColor: theme.colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildCategorySelection(ThemeData theme, dynamic categoriesState) {
    final categories = categoriesState.categories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Category', style: theme.textTheme.titleSmall),
        const Gap(12),
        if (categoriesState.isLoading)
          const Center(child: CircularProgressIndicator())
        else if (categories.isEmpty)
          Text('No categories found.', style: theme.textTheme.bodyMedium)
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map<Widget>((category) {
                final isSelected =
                    formController.selectedCategoryId == category.id;
                return GestureDetector(
                  onTap: () => setState(
                    () => formController.selectedCategoryId = category.id,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : theme.dividerColor.withValues(alpha: 0.05),
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          category.icon,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const Gap(8),
                        Text(
                          category.name,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isSelected
                                ? Colors.white
                                : theme.textTheme.bodyLarge?.color,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.1);
  }

  Widget _buildDatePickerCard(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date', style: theme.textTheme.titleSmall),
        const Gap(8),
        GestureDetector(
          onTap: _selectDate,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: 0.05),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  color: AppColors.primary,
                  size: 22,
                ),
                const Gap(12),
                Text(
                  formController.dateController.text.isEmpty
                      ? DateFormat.yMMMd().format(DateTime.now())
                      : formController.dateController.text,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(Icons.chevron_right_rounded, color: theme.disabledColor),
              ],
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildNotesSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Notes', style: theme.textTheme.titleSmall),
        const Gap(8),
        TextField(
          controller: formController.noteController,
          maxLines: 3,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Add any extra details...',
            filled: true,
            fillColor: theme.colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(20),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 500.ms);
  }
}
