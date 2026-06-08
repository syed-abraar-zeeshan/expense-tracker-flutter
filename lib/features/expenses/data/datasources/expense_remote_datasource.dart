import 'package:expense_flow/features/dashboard/data/models/transaction_model.dart';
import 'package:expense_flow/features/expenses/data/models/expense_request_model.dart';

abstract class ExpenseRemoteDataSource {
  Future<List<TransactionModel>> getTransactions();
  Future<void> createExpense({required ExpenseRequestModel request});
  Future<void> updateExpense({
    required String id,
    required ExpenseRequestModel request,
  });
  Future<void> deleteExpense({required String id});
}
