import 'package:expense_flow/core/constants/api_constants.dart';
import 'package:expense_flow/core/network/base_api_service.dart';
import 'package:expense_flow/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:expense_flow/features/auth/data/models/user_model.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final BaseApiService apiService;

  AuthRemoteDatasourceImpl({required this.apiService});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(
      ApiConstants.login,
      data: {'email': email, 'password': password},
    );

    return UserModel.fromJson(response.data['data']);
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(
      ApiConstants.register,
      data: {'name': name, 'email': email, 'password': password},
    );

    return UserModel.fromJson(response.data['data']);
  }

  @override
  Future<UserModel> getProfile() async {
    final response = await apiService.get(ApiConstants.profile);

    return UserModel.fromJson(response.data['data']);
  }
}
