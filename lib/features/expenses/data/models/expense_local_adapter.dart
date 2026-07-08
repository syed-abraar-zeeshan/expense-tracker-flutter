import 'package:hive/hive.dart';
import 'expense_local_model.dart';

class ExpenseLocalAdapter extends TypeAdapter<ExpenseLocalModel> {
  @override
  final int typeId = 0;

  @override
  ExpenseLocalModel read(BinaryReader reader) {
    return ExpenseLocalModel(
      id: reader.readString(),
      title: reader.readString(),
      amount: reader.readDouble(),
      type: reader.readString(),
      date: DateTime.parse(reader.readString()),
      categoryId: reader.readString(),
      categoryName: reader.readString(),
      categoryIcon: reader.readString(),
      categoryColor: reader.readString(),
      note: reader.read(),
      isSynced: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseLocalModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeDouble(obj.amount);
    writer.writeString(obj.type);
    writer.writeString(obj.date.toIso8601String());
    writer.writeString(obj.categoryId);
    writer.writeString(obj.categoryName);
    writer.writeString(obj.categoryIcon);
    writer.writeString(obj.categoryColor);
    writer.write(obj.note);
    writer.writeBool(obj.isSynced);
  }
}
