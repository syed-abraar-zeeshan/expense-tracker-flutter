import 'package:expense_flow/features/dashboard/data/models/dashboard_model.dart';

abstract class DashboardRemoteDatasource {
  Future<DashboardModel> getDashboard();
}
