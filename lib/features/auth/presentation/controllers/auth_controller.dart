import 'package:expense_flow/core/storage/secure_storage_provider.dart';
import 'package:expense_flow/features/auth/presentation/controllers/auth_state.dart';
import 'package:expense_flow/features/auth/presentation/providers/auth_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  AuthState build() {
    return const AuthState();
  }

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.login(email: email, password: password);
      if (user.token != null) {
        await ref.read(secureStorageProvider).saveToken(user.token!);
      }
      state = state.copyWith(isLoading: false, isAuthenticated: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.register(name: name, email: email, password: password);
      state = state.copyWith(isLoading: false, isRegistered: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> getProfile() async {
    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.getProfile();

      print(user.name);
      print(user.email);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> logout() async {
    await ref.read(secureStorageProvider).clearToken();
  }

  Future<bool> checkAuthStatus() async {
    final token = await ref.read(secureStorageProvider).getToken();

    print('TOKEN => $token');
    return token != null && token.isNotEmpty;
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
