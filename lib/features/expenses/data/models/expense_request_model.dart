class ExpenseRequestModel {
  final String title;
  final double amount;
  final String category;
  final String note;
  final String type;
  final DateTime date;

  ExpenseRequestModel({
    required this.title,
    required this.amount,
    required this.category,
    required this.note,
    required this.type,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'category': category,
      'note': note,
      'type': type,
      'date': date.toIso8601String(),
    };
  }
}
