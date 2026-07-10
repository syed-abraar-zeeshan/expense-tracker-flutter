import 'package:expense_flow/core/network/connectivity_service.dart';
import 'package:expense_flow/features/categories/domain/entities/category_entity.dart';
import 'package:expense_flow/features/dashboard/domain/enities/transaction_entity.dart';
import 'package:expense_flow/features/expenses/data/datasources/expense_local_datasource.dart';
import 'package:expense_flow/features/expenses/data/datasources/expense_remote_datasource.dart';
import 'package:expense_flow/features/expenses/data/mappers/expense_mapper.dart';
import 'package:expense_flow/features/expenses/data/models/expense_request_model.dart';
import 'package:expense_flow/features/expenses/domain/repositories/expense_repository.dart';
import 'package:flutter/foundation.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseRemoteDataSource remoteDatasource;
  final ExpenseLocalDataSource localDatasource;
  final ConnectivityService connectivityService;

  ExpenseRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.connectivityService,
  });

  @override
  Future<List<TransactionEntity>> getTransactions() async {
    final isConnected = await connectivityService.isConnected();
    if (isConnected) {
      return remoteDatasource.getTransactions();
    } else {
      final localExpenses = await localDatasource.getExpenses();
      return localExpenses.map(ExpenseMapper.toTransaction).toList();
    }
  }

  @override
  Future<void> createExpense({
    required ExpenseRequestModel request,
    required CategoryEntity category,
  }) async {
    final isConnected = await connectivityService.isConnected();
    if (isConnected) {
      await remoteDatasource.createExpense(request: request);
      final localExpense = ExpenseMapper.toLocal(
        request: request,
        category: category,
        isSynced: true,
      );
      await localDatasource.saveExpense(localExpense);
    } else {
      final localExpense = ExpenseMapper.toLocal(
        request: request,
        category: category,
        isSynced: false,
      );
      await localDatasource.saveExpense(localExpense);
    }
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

  @override
  Future<TransactionEntity> getExpenseById(String id) {
    return remoteDatasource.getExpenseById(id);
  }

  @override
  Future<void> syncPendingExpenses() async {
    final pendingExpenses = await localDatasource.getPendingSyncExpenses();
    for (final expense in pendingExpenses) {
      try {
        final request = ExpenseMapper.toRequest(expense);
        await remoteDatasource.createExpense(request: request);
        await localDatasource.updateExpense(expense.copyWith(isSynced: true));
      } catch (e) {
        if (kDebugMode) {
          print('Failed to sync ${expense.title}: $e');
        }
      }
    }
  }
}
