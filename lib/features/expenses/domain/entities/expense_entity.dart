class ExpenseRequestEntity {
  final String id;
  final String title;
  final double amount;
  final String categoryId;
  final String note;
  final String type;
  final DateTime date;

  ExpenseRequestEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.categoryId,
    required this.note,
    required this.type,
    required this.date,
  });
}
