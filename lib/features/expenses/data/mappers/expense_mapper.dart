import 'package:expense_flow/features/categories/domain/entities/category_entity.dart';
import 'package:expense_flow/features/dashboard/domain/enities/transaction_entity.dart';
import 'package:expense_flow/features/expenses/data/models/expense_local_model.dart';
import 'package:expense_flow/features/expenses/data/models/expense_request_model.dart';
import 'package:uuid/uuid.dart';

class ExpenseMapper {
  static final _uuid = Uuid();

  static ExpenseLocalModel toLocal({
    required ExpenseRequestModel request,
    required CategoryEntity category,
    bool isSynced = false,
  }) {
    return ExpenseLocalModel(
      id: _uuid.v4(),
      title: request.title,
      amount: request.amount,
      type: request.type,
      date: request.date,

      categoryId: category.id,
      categoryName: category.name,
      categoryIcon: category.icon,
      categoryColor: category.color,

      note: request.note,
      isSynced: isSynced,
    );
  }

  static ExpenseRequestModel toRequest(ExpenseLocalModel expense) {
    return ExpenseRequestModel(
      title: expense.title,
      amount: expense.amount,
      category: expense.categoryId,
      type: expense.type,
      date: expense.date,
      note: expense.note ?? "",
    );
  }

  static TransactionEntity toTransaction(ExpenseLocalModel expense) {
    return TransactionEntity(
      id: expense.id,
      title: expense.title,
      amount: expense.amount,
      type: expense.type,
      date: expense.date,
      category: CategoryEntity(
        id: expense.categoryId,
        name: expense.categoryName,
        icon: expense.categoryIcon,
        color: expense.categoryColor,
      ),
      note: expense.note,
    );
  }
}
