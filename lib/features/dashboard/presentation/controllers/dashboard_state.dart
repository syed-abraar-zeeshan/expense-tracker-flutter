import 'package:expense_flow/features/dashboard/domain/enities/dashboard_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_state.freezed.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(false) bool isLoading,
    DashboardEntity? dashboard,
    String? errorMessage,
  }) = _DashboardState;
}
