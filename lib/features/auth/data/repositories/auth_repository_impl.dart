import 'package:expense_flow/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:expense_flow/features/auth/domain/entities/user_entity.dart';
import 'package:expense_flow/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<UserEntity> login({required String email, required String password}) {
    return remoteDatasource.login(email: email, password: password);
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) {
    return remoteDatasource.register(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Future<UserEntity> getProfile() {
    return remoteDatasource.getProfile();
  }

  @override
  Future<void> forgotPassword({required String email}) {
    return remoteDatasource.forgotPassword(email: email);
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String password,
    required String token,
  }) {
    return remoteDatasource.resetPassword(
      email: email,
      password: password,
      token: token,
    );
  }

  @override
  Future<void> logout() async {}
}
