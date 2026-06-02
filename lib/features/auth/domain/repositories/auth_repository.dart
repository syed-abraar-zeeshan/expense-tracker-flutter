import 'package:expense_flow/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  // Triggers a registration request to the server
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  });

  // Triggers a verification request to the server
  Future<UserEntity> login({required String email, required String password});

  // Retrieves the current user profile from the backend session
  Future<UserEntity> getProfile();

  // Checks if there is an active access token saved locally on the device
  Future<bool> isUserLoggedIn();

  // Clears the saved secure token blocks to clear down the session
  Future<void> logout();
}
