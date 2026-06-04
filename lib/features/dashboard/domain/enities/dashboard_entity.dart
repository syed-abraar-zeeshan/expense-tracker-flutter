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

class CategoryEntity {
  final String id;
  final String name;
  final String icon;
  final String color;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}
