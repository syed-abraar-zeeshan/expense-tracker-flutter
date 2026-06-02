import 'package:expense_flow/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:expense_flow/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:expense_flow/features/auth/domain/entities/user_entity.dart';
import 'package:expense_flow/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final userModel = await _remoteDataSource.register(
      name: name,
      email: email,
      password: password,
    );

    // Save token if it exists (some APIs return token on register, others don't)
    if (userModel.token != null) {
      await _localDataSource.saveAccessToken(token: userModel.token!);
    }

    return userModel;
  }

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final userModel = await _remoteDataSource.login(
      email: email,
      password: password,
    );

    if (userModel.token != null) {
      await _localDataSource.saveAccessToken(token: userModel.token!);
    }

    return userModel;
  }

  @override
  Future<UserEntity> getProfile() async {
    return await _remoteDataSource.getProfile();
  }

  @override
  Future<bool> isUserLoggedIn() async {
    final token = await _localDataSource.getAccessToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> logout() async {
    await _localDataSource.clearAccessToken();
  }
}
