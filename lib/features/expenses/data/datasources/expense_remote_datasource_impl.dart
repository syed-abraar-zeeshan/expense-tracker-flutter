import 'package:expense_flow/core/constants/api_constants.dart';
import 'package:expense_flow/core/network/base_api_service.dart';
import 'package:expense_flow/features/expenses/data/datasources/expense_remote_datasource.dart';
import 'package:expense_flow/features/expenses/data/models/expense_request_model.dart';

class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  final BaseApiService apiService;

  ExpenseRemoteDataSourceImpl({required this.apiService});

  @override
  Future<void> createExpense({required ExpenseRequestModel request}) async {
    await apiService.post(ApiConstants.expenses, data: request.toJson());
  }
}
