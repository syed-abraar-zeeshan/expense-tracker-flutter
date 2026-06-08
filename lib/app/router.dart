import 'package:expense_flow/core/widgets/main_navigation_wrapper.dart';
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
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/splash',
  navigatorKey: _rootNavigatorKey,
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
    
    // Persistent Navigation Shell
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainNavigationWrapper(navigationShell: navigationShell);
      },
      branches: [
        // Branch 0: Dashboard
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),
        // Branch 1: Expenses
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/expenses',
              builder: (context, state) => const ExpenseListScreen(),
            ),
          ],
        ),
        // Branch 2: Categories
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/categories',
              builder: (context, state) => const CategoriesScreen(),
            ),
          ],
        ),
        // Branch 3: Profile
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),

    // Other Global Routes
    GoRoute(
      path: '/add-expense',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AddExpenseScreen(),
    ),
    GoRoute(
      path: '/edit-expense',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final transaction = state.extra as TransactionEntity;
        return EditExpenseScreen(transaction: transaction);
      },
    ),
  ],
);
