import 'package:expense_flow/features/dashboard/domain/enities/transaction_entity.dart';
import 'package:expense_flow/features/expenses/presentation/providers/expense_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transactions_controller.g.dart';

@riverpod
class TransactionsController extends _$TransactionsController {
  @override
  FutureOr<List<TransactionEntity>> build() async {
    return _fetchTransactions();
  }

  Future<List<TransactionEntity>> _fetchTransactions() async {
    return ref.read(expenseRepositoryProvider).getTransactions();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(() => _fetchTransactions());
    if (ref.mounted) {
      state = result;
    }
  }
}
