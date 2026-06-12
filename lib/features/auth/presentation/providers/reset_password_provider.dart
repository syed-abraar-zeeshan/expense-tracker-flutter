import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reset_password_provider.g.dart';

@riverpod
class ResetPasswordVisibility extends _$ResetPasswordVisibility {
  @override
  bool build() => true;

  void toggle() => state = !state;
}

@riverpod
class ResetConfirmPasswordVisibility extends _$ResetConfirmPasswordVisibility {
  @override
  bool build() => true;

  void toggle() => state = !state;
}
