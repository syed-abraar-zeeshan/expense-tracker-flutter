import 'package:expense_flow/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> getProfile();
}
