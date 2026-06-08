import 'package:expense_flow/features/dashboard/domain/enities/transaction_entity.dart';
import 'package:expense_flow/features/expenses/data/models/expense_request_model.dart';

abstract class ExpenseRepository {
  Future<List<TransactionEntity>> getTransactions();
  Future<void> createExpense({required ExpenseRequestModel request});
  Future<void> updateExpense({
    required String id,
    required ExpenseRequestModel request,
  });
  Future<void> deleteExpense({required String id});
}
