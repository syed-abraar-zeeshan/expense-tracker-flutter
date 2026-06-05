import 'package:expense_flow/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_flow/features/categories/data/datasources/category_remote_datasource.dart';
import 'package:expense_flow/features/categories/data/datasources/category_remote_datasource_impl.dart';
import 'package:expense_flow/features/categories/data/repositories/category_repository_impl.dart';
import 'package:expense_flow/features/categories/domain/repositories/category_repository.dart';

final categoryRemoteDataSourceProvider = Provider<CategoryRemoteDatasource>((
  ref,
) {
  return CategoryRemoteDataSourceImpl(
    apiService: ref.watch(apiServiceProvider),
  );
});

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepositoryImpl(
    categoryRemoteDatasource: ref.watch(categoryRemoteDataSourceProvider),
  );
});
