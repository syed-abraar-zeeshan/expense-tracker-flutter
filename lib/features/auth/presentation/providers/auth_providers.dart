import 'package:expense_flow/core/network/api_client.dart';
import 'package:expense_flow/core/network/base_api_service.dart';
import 'package:expense_flow/core/storage/secure_storage_provider.dart';
import 'package:expense_flow/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:expense_flow/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:expense_flow/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:expense_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceProvider = Provider<BaseApiService>((ref) {
  final storage = ref.watch(secureStorageProvider);
  final dio = ApiClient.create(storage);
  return BaseApiService(dio);
});

final authRemoteDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  return AuthRemoteDatasourceImpl(apiService: ref.watch(apiServiceProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDatasource: ref.watch(authRemoteDatasourceProvider),
  );
});
