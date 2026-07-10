import 'package:expense_flow/features/categories/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';

class ExpenseFormController {
  ExpenseFormController() {
    selectedDate = DateTime.now();

    dateController.text =
        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
  }

  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  final dateController = TextEditingController();

  // String? selectedCategoryId;
  CategoryEntity? selectedCategory;
  String selectedType = 'expense';

  late DateTime selectedDate;

  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  void dispose() {
    titleController.dispose();
    amountController.dispose();
    noteController.dispose();
    dateController.dispose();
  }
}
