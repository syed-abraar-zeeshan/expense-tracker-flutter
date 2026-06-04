import 'package:expense_flow/features/dashboard/domain/enities/dashboard_entity.dart';

abstract class DashboardRepository {
  Future<DashboardEntity> getDashboard();
}
