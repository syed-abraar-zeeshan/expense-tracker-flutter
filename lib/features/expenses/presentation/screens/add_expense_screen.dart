import 'dart:io';

import 'package:expense_flow/core/widgets/app_button.dart';
import 'package:expense_flow/core/widgets/app_dropdown.dart';
import 'package:expense_flow/core/widgets/app_snackbar.dart';
import 'package:expense_flow/core/widgets/app_text_field.dart';
import 'package:expense_flow/features/categories/presentation/controllers/categories_controller.dart';
import 'package:expense_flow/features/expenses/data/models/expense_request_model.dart';
import 'package:expense_flow/features/expenses/presentation/controllers/expense_controller.dart';
import 'package:expense_flow/features/expenses/presentation/form/expense_form_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  ConsumerState<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  final formController = ExpenseFormController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(categoriesControllerProvider.notifier).getCategories();
    });
  }

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    if (Platform.isIOS) {
      DateTime selectedDate = DateTime.now();

      showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return Container(
            height: 300,
            color: Colors.white,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                    child: const Text('Done'),
                    onPressed: () {
                      formController.dateController.text =
                          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';

                      Navigator.pop(context);

                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
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
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
      );

      if (pickedDate != null) {
        formController.dateController.text =
            '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';

        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoriesControllerProvider);
    ref.listen(expenseControllerProvider, (previous, next) {
      if (next.isSuccess) {
        AppSnackbar.show(
          context,
          message: 'Expense added successfully',
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
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AppTextField(
              controller: formController.titleController,
              labelText: 'Title',
              hintText: 'Enter expense title',
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: formController.amountController,
              labelText: 'Amount',
              hintText: 'Enter amount',
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.currency_rupee),
            ),
            const SizedBox(height: 16),
            AppDropdown<String>(
              labelText: 'Category',
              value: formController.selectedCategoryId,
              hintText: 'Select Category',
              // prefixIcon: const Icon(Icons.category),
              items: state.categories.map((category) {
                return DropdownMenuItem(
                  value: category.id,
                  child: Text('${category.icon} ${category.name}'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  formController.selectedCategoryId = value;
                });
              },
            ),
            const SizedBox(height: 16),
            AppDropdown<String>(
              labelText: 'Type',
              value: formController.selectedType,
              hintText: 'Select Type',
              prefixIcon: const Icon(Icons.swap_vert),

              items: const [
                DropdownMenuItem(value: 'expense', child: Text('Expense')),
                DropdownMenuItem(value: 'income', child: Text('Income')),
              ],

              onChanged: (value) {
                setState(() {
                  formController.selectedType = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: formController.dateController,
              labelText: 'Date',
              hintText: 'Select Date',
              readOnly: true,
              prefixIcon: const Icon(Icons.calendar_today),
              onTap: _selectDate,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: formController.noteController,
              labelText: 'Note',
              hintText: 'Optional note',
              maxLines: 3,
              prefixIcon: const Icon(Icons.notes),
            ),

            const SizedBox(height: 24),

            AppButton(
              text: 'Save Expense',
              onPressed: () async {
                final request = ExpenseRequestModel(
                  title: formController.titleController.text.trim(),
                  amount: double.parse(
                    formController.amountController.text.trim(),
                  ),
                  category: formController.selectedCategoryId ?? '',
                  note: formController.noteController.text.trim(),
                  type: formController.selectedType,
                  date: formController.selectedDate,
                );

                print(request.toJson());

                // Next Step
                await ref
                    .read(expenseControllerProvider.notifier)
                    .createExpense(request: request);
              },
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
