import 'package:expense_flow/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:expense_flow/features/expenses/data/models/expense_request_model.dart';
import 'package:expense_flow/features/expenses/presentation/controllers/expense_state.dart';
import 'package:expense_flow/features/expenses/presentation/controllers/transactions_controller.dart';
import 'package:expense_flow/features/expenses/presentation/providers/expense_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_controller.g.dart';

@riverpod
class ExpenseController extends _$ExpenseController {
  @override
  ExpenseState build() {
    return const ExpenseState();
  }

  Future<void> createExpense({required ExpenseRequestModel request}) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      isSuccess: false,
    );

    try {
      await ref.read(expenseRepositoryProvider).createExpense(request: request);
      
      // Refresh dashboard and transactions list immediately
      await ref.read(dashboardControllerProvider.notifier).getDashboard();
      await ref.read(transactionsControllerProvider.notifier).refresh();

      if (!ref.mounted) return;

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      if (!ref.mounted) return;

      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> updateExpense({
    required String id,
    required ExpenseRequestModel request,
  }) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      isSuccess: false,
    );

    try {
      await ref
          .read(expenseRepositoryProvider)
          .updateExpense(id: id, request: request);

      // Refresh dashboard and transactions list immediately
      await ref.read(dashboardControllerProvider.notifier).getDashboard();
      await ref.read(transactionsControllerProvider.notifier).refresh();

      if (!ref.mounted) return;

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      if (!ref.mounted) return;

      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> deleteExpense({required String id}) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      isSuccess: false,
    );

    try {
      await ref.read(expenseRepositoryProvider).deleteExpense(id: id);

      // Refresh dashboard and transactions list immediately
      await ref.read(dashboardControllerProvider.notifier).getDashboard();
      await ref.read(transactionsControllerProvider.notifier).refresh();

      if (!ref.mounted) return;

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      if (!ref.mounted) return;

      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

