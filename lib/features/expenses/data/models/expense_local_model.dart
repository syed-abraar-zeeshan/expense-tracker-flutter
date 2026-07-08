class ExpenseLocalModel {
  final String id;
  final String title;
  final double amount;
  final String type;
  final DateTime date;

  final String categoryId;
  final String categoryName;
  final String categoryIcon;
  final String categoryColor;

  final String? note;

  final bool isSynced;

  const ExpenseLocalModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    required this.categoryId,
    required this.categoryName,
    required this.categoryIcon,
    required this.categoryColor,
    this.note,
    this.isSynced = false,
  });
}
