import 'package:expense_flow/features/expenses/data/models/expense_request_model.dart';

abstract class ExpenseRemoteDataSource {
  Future<void> createExpense({required ExpenseRequestModel request});
}
