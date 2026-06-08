import 'package:expense_flow/core/constants/api_constants.dart';
import 'package:expense_flow/core/network/base_api_service.dart';
import 'package:expense_flow/features/dashboard/data/models/transaction_model.dart';
import 'package:expense_flow/features/expenses/data/datasources/expense_remote_datasource.dart';
import 'package:expense_flow/features/expenses/data/models/expense_request_model.dart';

class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  final BaseApiService apiService;

  ExpenseRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final response = await apiService.get(ApiConstants.expenses);
    return (response.data['data'] as List)
        .map((e) => TransactionModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> createExpense({required ExpenseRequestModel request}) async {
    await apiService.post(ApiConstants.expenses, data: request.toJson());
  }

  @override
  Future<void> updateExpense({
    required String id,
    required ExpenseRequestModel request,
  }) async {
    await apiService.put(
      '${ApiConstants.expenses}/$id',
      data: request.toJson(),
    );
  }

  @override
  Future<void> deleteExpense({required String id}) async {
    await apiService.delete('${ApiConstants.expenses}/$id');
  }
}
