import 'package:expense_flow/core/constants/api_constants.dart';
import 'package:expense_flow/features/auth/data/models/user_model.dart';
import 'package:expense_flow/core/network/base_api_service.dart';

class AuthRemoteDataSource {
  final BaseApiService _apiService = BaseApiService();

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _apiService.postAPI(ApiConstants.register, {
      'name': name,
      'email': email,
      'password': password,
    });
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiService.postAPI(ApiConstants.login, {
      'email': email,
      'password': password,
    });
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> getProfile() async {
    // The Interceptor handles the token automatically via BaseApiService
    final response = await _apiService.getAPI(ApiConstants.profile);
    return UserModel.fromJson(response.data);
  }
}
