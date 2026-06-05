import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_state.freezed.dart';

@freezed
abstract class ExpenseState with _$ExpenseState {
  const factory ExpenseState({
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? errorMessage,
  }) = _ExpenseState;
}
