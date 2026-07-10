import 'package:expense_flow/core/sync/sync_manager.dart';
import 'package:expense_flow/features/expenses/presentation/providers/expense_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//tells Riverpod that this provider returns a SyncManager object.
final syncManagerProvider = Provider<SyncManager>((ref) {
  final syncManager = SyncManager(
    connectivityService: ref.watch(connectivityServiceProvider),
    expenseRepository: ref.watch(expenseRepositoryProvider),
  );
  syncManager.start();

  ref.onDispose(() {
    syncManager.dispose();
  });

  return syncManager;
});
