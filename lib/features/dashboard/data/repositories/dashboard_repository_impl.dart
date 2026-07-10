import 'package:expense_flow/core/network/connectivity_service.dart';
import 'package:expense_flow/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:expense_flow/features/dashboard/domain/enities/dashboard_entity.dart';
import 'package:expense_flow/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:expense_flow/features/expenses/data/datasources/expense_local_datasource.dart';
import 'package:expense_flow/features/expenses/data/mappers/expense_mapper.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDatasource dashboardRemoteDatasource;
  final ExpenseLocalDataSource expenseLocalDataSource;
  final ConnectivityService connectivityService;

  DashboardRepositoryImpl({
    required this.dashboardRemoteDatasource,
    required this.expenseLocalDataSource,
    required this.connectivityService,
  });

  @override
  Future<DashboardEntity> getDashboard() async {
    final isConnected = await connectivityService.isConnected();

    if (isConnected) {
      return dashboardRemoteDatasource.getDashboard();
    }

    final expenses = await expenseLocalDataSource.getExpenses();

    final transactions = expenses.map(ExpenseMapper.toTransaction).toList();

    transactions.sort((a, b) => b.date.compareTo(a.date));

    final totalIncome = transactions
        .where((e) => e.type == 'income')
        .fold(0.0, (sum, e) => sum + e.amount);

    final totalExpense = transactions
        .where((e) => e.type == 'expense')
        .fold(0.0, (sum, e) => sum + e.amount);

    return DashboardEntity(
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      balance: totalIncome - totalExpense,
      transactionCount: transactions.length,
      recentTransactions: transactions,
    );
  }
}
