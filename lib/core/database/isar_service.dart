import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
// Note: We will add your generated collection schemas here once they are written.

class IsarService {
  IsarService._(); // Private constructor
  static final IsarService instance = IsarService._();

  late final Isar _db;

  /// Exposes the active Isar instance safely across data sources
  Isar get db => _db;

  /// Initializes and configures the local database engine
  Future<void> init() async {
    // 1. Resolve the device's secure physical document storage directory
    final dir = await getApplicationDocumentsDirectory();

    // 2. Open the Isar instance with our upcoming collection structural mappings
    _db = await Isar.open(
      [], // We will pass your [ExpenseModelSchema], [CategoryModelSchema] here shortly
      directory: dir.path,
      inspector:
          true, // Enables local database debugging tool profile in development mode
    );
  }
}
