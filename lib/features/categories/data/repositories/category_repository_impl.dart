import 'package:expense_flow/features/categories/data/datasources/category_remote_datasource.dart';
import 'package:expense_flow/features/categories/domain/entities/category_entity.dart';
import 'package:expense_flow/features/categories/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDatasource categoryRemoteDatasource;

  CategoryRepositoryImpl({required this.categoryRemoteDatasource});

  @override
  Future<List<CategoryEntity>> getCategories() async {
    return categoryRemoteDatasource.getCategories();
  }
}
