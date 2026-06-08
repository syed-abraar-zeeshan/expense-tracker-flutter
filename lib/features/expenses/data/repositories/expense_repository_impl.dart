import 'package:expense_flow/features/dashboard/domain/enities/transaction_entity.dart';
import 'package:expense_flow/features/expenses/data/datasources/expense_remote_datasource.dart';
import 'package:expense_flow/features/expenses/data/models/expense_request_model.dart';
import 'package:expense_flow/features/expenses/domain/repositories/expense_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseRemoteDataSource remoteDatasource;

  ExpenseRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<TransactionEntity>> getTransactions() {
    return remoteDatasource.getTransactions();
  }

  @override
  Future<void> createExpense({required ExpenseRequestModel request}) {
    return remoteDatasource.createExpense(request: request);
  }

  @override
  Future<void> updateExpense({
    required String id,
    required ExpenseRequestModel request,
  }) {
    return remoteDatasource.updateExpense(id: id, request: request);
  }

  @override
  Future<void> deleteExpense({required String id}) {
    return remoteDatasource.deleteExpense(id: id);
  }
}
