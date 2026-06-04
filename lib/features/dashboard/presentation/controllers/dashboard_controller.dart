import 'package:expense_flow/features/dashboard/presentation/controllers/dashboard_state.dart';
import 'package:expense_flow/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_controller.g.dart';

@riverpod
class DashboardController extends _$DashboardController {
  @override
  DashboardState build() {
    return const DashboardState();
  }

  Future<void> getDashboard() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final dashboard = await ref
          .read(dashboardRepositoryProvider)
          .getDashboard();

      state = state.copyWith(isLoading: false, dashboard: dashboard);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
