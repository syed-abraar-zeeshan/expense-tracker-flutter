import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_provider.g.dart';

@riverpod
class PasswordVisibility extends _$PasswordVisibility {
  @override
  bool build() => true;

  void toggle() {
    state = !state;
  }
}

@riverpod
class ConfirmPasswordVisibility extends _$ConfirmPasswordVisibility {
  @override
  bool build() => true;

  void toggle() {
    state = !state;
  }
}
