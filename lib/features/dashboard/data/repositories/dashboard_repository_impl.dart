import 'package:expense_flow/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:expense_flow/features/dashboard/domain/enities/dashboard_entity.dart';
import 'package:expense_flow/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDatasource dashboardRemoteDatasource;

  DashboardRepositoryImpl({required this.dashboardRemoteDatasource});

  @override
  Future<DashboardEntity> getDashboard() {
    return dashboardRemoteDatasource.getDashboard();
  }
}
