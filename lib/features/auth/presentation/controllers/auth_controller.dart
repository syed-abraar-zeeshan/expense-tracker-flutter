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

  Future<void> forgotPassword({required String email}) async {
    state = state.copyWith(isLoading: true, errorMessage: null, isPasswordResetSent: false);
    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.forgotPassword(email: email);
      state = state.copyWith(isLoading: false, isPasswordResetSent: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> resetPassword({
    required String email,
    required String password,
    required String token,
  }) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      isPasswordResetSuccess: false,
    );
    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.resetPassword(
        email: email,
        password: password,
        token: token,
      );
      state = state.copyWith(isLoading: false, isPasswordResetSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> getProfile() async {
    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.getProfile();

      if (!ref.mounted) return;

      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      if (!ref.mounted) return;

      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> logout() async {
    await ref.read(secureStorageProvider).clearToken();
    state = const AuthState();
  }

  Future<bool> checkAuthStatus() async {
    final token = await ref.read(secureStorageProvider).getToken();

    return token != null && token.isNotEmpty;
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
