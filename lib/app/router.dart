import 'package:expense_flow/features/auth/presentation/screens/login_screen.dart';
import 'package:expense_flow/features/auth/presentation/screens/register_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
  ],
);
