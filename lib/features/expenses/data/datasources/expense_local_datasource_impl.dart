import 'package:expense_flow/core/local/hive_boxes.dart';
import 'package:expense_flow/features/expenses/data/datasources/expense_local_datasource.dart';
import 'package:expense_flow/features/expenses/data/models/expense_local_model.dart';
import 'package:hive/hive.dart';

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final Box<ExpenseLocalModel> _box = Hive.box<ExpenseLocalModel>(
    HiveBoxes.expenses,
  );

  @override
  Future<void> saveExpense(ExpenseLocalModel expense) async {
    await _box.put(expense.id, expense);
  }

  @override
  Future<List<ExpenseLocalModel>> getExpenses() async {
    return _box.values.toList();
  }

  @override
  Future<void> updateExpense(ExpenseLocalModel expense) async {
    await _box.put(expense.id, expense);
  }

  @override
  Future<void> deleteExpense(String id) async {
    await _box.delete(id);
  }

  @override
  Future<ExpenseLocalModel?> getExpenseById(String id) async {
    return _box.get(id);
  }

  @override
  Future<List<ExpenseLocalModel>> getPendingSyncExpenses() async {
    return _box.values.where((expense) => !expense.isSynced).toList();
  }
}
