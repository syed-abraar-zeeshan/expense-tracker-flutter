import 'package:expense_flow/app/router.dart';
import 'package:expense_flow/features/expenses/presentation/controllers/expense_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationNavigationService {
  Future<void> openExpense(String expenseId) async {
    final container = ProviderContainer();

    final transaction = await container
        .read(expenseControllerProvider.notifier)
        .getExpenseById(expenseId);

    appRouter.push("/edit-expense", extra: transaction);

    container.dispose();
  }
}
