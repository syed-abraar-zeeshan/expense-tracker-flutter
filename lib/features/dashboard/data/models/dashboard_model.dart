import 'package:expense_flow/features/dashboard/data/models/transaction_model.dart';
import 'package:expense_flow/features/dashboard/domain/enities/dashboard_entity.dart';

class DashboardModel extends DashboardEntity {
  const DashboardModel({
    required super.totalIncome,
    required super.totalExpense,
    required super.balance,
    required super.transactionCount,
    required super.recentTransactions,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalIncome: (json['totalIncome'] as num).toDouble(),
      totalExpense: (json['totalExpense'] as num).toDouble(),
      balance: (json['balance'] as num).toDouble(),
      transactionCount: json['transactionCount'] as int,
      recentTransactions: (json['recentTransactions'] as List)
          .map(
            (transaction) =>
                TransactionModel.fromJson(transaction as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      'balance': balance,
      'transactionCount': transactionCount,
      'recentTransactions': recentTransactions
          .map((transaction) => (transaction as TransactionModel).toJson())
          .toList(),
    };
  }
}
