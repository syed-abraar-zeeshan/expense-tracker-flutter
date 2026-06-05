import 'package:expense_flow/features/dashboard/domain/enities/transaction_entity.dart';

class DashboardEntity {
  final double totalIncome;
  final double totalExpense;
  final double balance;
  final int transactionCount;
  final List<TransactionEntity> recentTransactions;

  const DashboardEntity({
    required this.totalIncome,
    required this.totalExpense,
    required this.balance,
    required this.transactionCount,
    required this.recentTransactions,
  });
}
