import 'package:expense_flow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_flow/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:expense_flow/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:expense_flow/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:expense_flow/features/auth/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: AuthRemoteDataSource(),
    localDataSource: AuthLocalDataSource(),
  );
});

final authProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    final repository = ref.read(authRepositoryProvider);
    return AuthController(repository);
  },
);
