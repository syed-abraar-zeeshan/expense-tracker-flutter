import 'package:expense_flow/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_flow/features/expenses/data/datasources/expense_remote_datasource.dart';
import 'package:expense_flow/features/expenses/data/datasources/expense_remote_datasource_impl.dart';
import 'package:expense_flow/features/expenses/data/repositories/expense_repository_impl.dart';
import 'package:expense_flow/features/expenses/domain/repositories/expense_repository.dart';

final expenseRemoteDatasourceProvider = Provider<ExpenseRemoteDataSource>((
  ref,
) {
  return ExpenseRemoteDataSourceImpl(apiService: ref.read(apiServiceProvider));
});

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepositoryImpl(
    remoteDatasource: ref.read(expenseRemoteDatasourceProvider),
  );
});
