import 'package:expense_flow/core/local/hive_boxes.dart';
import 'package:expense_flow/features/expenses/data/models/expense_local_adapter.dart';
import 'package:expense_flow/features/expenses/data/models/expense_local_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Future<void> initialize() async {
    await Hive.initFlutter();

    // Register Adapter
    Hive.registerAdapter(ExpenseLocalAdapter());

    // Open Boxes
    await Hive.openBox<ExpenseLocalModel>(HiveBoxes.expenses);
    await Hive.openBox(HiveBoxes.categories);
    await Hive.openBox(HiveBoxes.settings);
    await Hive.openBox(HiveBoxes.pendingSync);
  }
}
