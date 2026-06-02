import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_flow/features/auth/domain/entities/user_entity.dart';
import 'package:expense_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:expense_flow/core/network/api_exception.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final UserEntity? user;

  AuthState({
    this.isLoading = false,
    this.error,
    this.user,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    UserEntity? user,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      user: user ?? this.user,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthController(this._repository) : super(AuthState());

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _repository.login(email: email, password: password);
      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      if (e is ApiException) {
        state = state.copyWith(
          isLoading: false,
          error: getFriendlyMessage(e.message),
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Something went wrong. Please try again.',
        );
      }
    }
  }

  Future<void> register(
    String name,
    String email,
    String password,
  ) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _repository.register(
        name: name,
        email: email,
        password: password,
      );
      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      if (e is ApiException) {
        state = state.copyWith(
          isLoading: false,
          error: getFriendlyMessage(e.message),
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Something went wrong. Please try again.',
        );
      }
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = AuthState(); // Reset to initial state
  }

  String getFriendlyMessage(String message) {
    switch (message.toLowerCase()) {
      case 'user already exists':
        return 'This email is already registered. Please sign in instead.';
      case 'invalid credentials':
        return 'Incorrect email or password.';
      default:
        return message;
    }
  }
}
