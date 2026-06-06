import 'package:expense_flow/features/auth/presentation/screens/splash_screen.dart';
import 'package:expense_flow/features/dashboard/domain/enities/transaction_entity.dart';
import 'package:expense_flow/features/expenses/presentation/screens/edit_expense_screen.dart';
import 'package:expense_flow/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:expense_flow/features/auth/presentation/screens/login_screen.dart';
import 'package:expense_flow/features/auth/presentation/screens/register_screen.dart';
import 'package:expense_flow/features/categories/presentation/screens/categories_screen.dart';
import 'package:expense_flow/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:expense_flow/features/expenses/presentation/screens/add_expense_screen.dart';
import 'package:expense_flow/features/expenses/presentation/screens/expense_list_screen.dart';
import 'package:expense_flow/features/profile/presentation/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/add-expense',
      builder: (context, state) => const AddExpenseScreen(),
    ),
    GoRoute(
      path: '/edit-expense',
      builder: (context, state) {
        final transaction = state.extra as TransactionEntity;
        return EditExpenseScreen(transaction: transaction);
      },
    ),
    GoRoute(
      path: '/expenses',
      builder: (context, state) => const ExpenseListScreen(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
