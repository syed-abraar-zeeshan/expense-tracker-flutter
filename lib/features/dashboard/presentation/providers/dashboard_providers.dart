import 'package:expense_flow/features/auth/presentation/providers/auth_providers.dart';
import 'package:expense_flow/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:expense_flow/features/dashboard/data/datasources/dashboard_remote_datasource_impl.dart';
import 'package:expense_flow/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:expense_flow/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardRemoteDatasourceProvider = Provider<DashboardRemoteDatasource>((
  ref,
) {
  return DashboardRemoteDatasourceImpl(
    apiService: ref.watch(apiServiceProvider),
  );
});

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepositoryImpl(
    dashboardRemoteDatasource: ref.watch(dashboardRemoteDatasourceProvider),
  );
});
