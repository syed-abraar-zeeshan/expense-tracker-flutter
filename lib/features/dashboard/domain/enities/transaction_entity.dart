import 'package:expense_flow/features/dashboard/domain/enities/dashboard_entity.dart';

class TransactionEntity {
  final String id;
  final String title;
  final double amount;
  final String type;
  final DateTime date;
  final CategoryEntity category;

  const TransactionEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    required this.category,
  });
}
