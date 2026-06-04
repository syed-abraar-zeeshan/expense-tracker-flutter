import 'package:expense_flow/core/constants/api_constants.dart';
import 'package:expense_flow/core/network/base_api_service.dart';
import 'package:expense_flow/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:expense_flow/features/dashboard/data/models/dashboard_model.dart';

class DashboardRemoteDatasourceImpl implements DashboardRemoteDatasource {
  final BaseApiService apiService;

  DashboardRemoteDatasourceImpl({required this.apiService});

  @override
  Future<DashboardModel> getDashboard() async {
    final response = await apiService.get(ApiConstants.dashboard);

    return DashboardModel.fromJson(response.data['data']);
  }
}
