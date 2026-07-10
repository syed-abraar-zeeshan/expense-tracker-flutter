import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:expense_flow/core/network/connectivity_service.dart';
import 'package:expense_flow/features/expenses/domain/repositories/expense_repository.dart';

class SyncManager {
  //Dependencies
  final ConnectivityService
  connectivityService; //to listen for internet changes.
  final ExpenseRepository expenseRepository; //to sync pending expenses.

  StreamSubscription? _subscription; // Creates a listener variable

  SyncManager({
    required this.connectivityService,
    required this.expenseRepository,
  });

  //listen:- the stream emits an event:
  void start() {
    _subscription = connectivityService.onConnectivityChanged.listen((
      result,
    ) async {
      if (!result.contains(ConnectivityResult.none)) {
        await expenseRepository.syncPendingExpenses();
      }
    });
  }

  //stops the listener.
  void dispose() {
    _subscription?.cancel();
  }
}
