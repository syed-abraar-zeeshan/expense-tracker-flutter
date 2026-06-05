import 'package:expense_flow/core/network/base_api_service.dart';
import 'package:expense_flow/features/categories/data/datasources/category_remote_datasource.dart';
import 'package:expense_flow/features/categories/data/models/category_model.dart';

class CategoryRemoteDataSourceImpl implements CategoryRemoteDatasource {
  final BaseApiService apiService;

  CategoryRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await apiService.get('/categories');

    final List<dynamic> data = response.data['data'];

    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }
}
