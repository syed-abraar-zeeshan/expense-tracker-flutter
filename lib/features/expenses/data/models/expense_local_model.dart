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

  ExpenseLocalModel copyWith({
    String? id,
    String? title,
    double? amount,
    String? type,
    DateTime? date,
    String? categoryId,
    String? categoryName,
    String? categoryIcon,
    String? categoryColor,
    String? note,
    bool? isSynced,
  }) {
    return ExpenseLocalModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      categoryIcon: categoryIcon ?? this.categoryIcon,
      categoryColor: categoryColor ?? this.categoryColor,
      note: note ?? this.note,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}
