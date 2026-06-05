import 'package:expense_flow/features/auth/domain/entities/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    @Default(false) bool isAuthenticated,
    @Default(false) bool isRegistered,
    UserEntity? user,
    String? errorMessage,
  }) = _AuthState;
}
