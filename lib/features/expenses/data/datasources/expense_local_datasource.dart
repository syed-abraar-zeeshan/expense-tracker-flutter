import 'package:expense_flow/features/expenses/data/models/expense_local_model.dart';

abstract class ExpenseLocalDataSource {
  Future<void> saveExpense(ExpenseLocalModel expense);
  Future<List<ExpenseLocalModel>> getExpenses();
  Future<void> updateExpense(ExpenseLocalModel expense);
  Future<void> deleteExpense(String id);
  Future<ExpenseLocalModel?> getExpenseById(String id);
  Future<List<ExpenseLocalModel>> getPendingSyncExpenses();
}
