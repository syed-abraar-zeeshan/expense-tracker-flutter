import 'package:expense_flow/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> getProfile();
  Future<void> forgotPassword({required String email});
  Future<void> resetPassword({
    required String email,
    required String password,
    required String token,
  });
}
