import 'package:expense_flow/core/constants/path_constants.dart';
import 'package:expense_flow/features/auth/presentation/screens/login_screen.dart';
import 'package:expense_flow/features/auth/presentation/screens/register_screen.dart';
import 'package:expense_flow/features/expenses/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: PathConstants.login,
  routes: [
    GoRoute(
      path: PathConstants.login,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: PathConstants.register,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: RegisterScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: PathConstants.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
