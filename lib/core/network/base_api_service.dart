import 'package:dio/dio.dart';
import 'dio_client.dart';
import 'api_exception.dart';

class BaseApiService {
  // We use the same unified Dio instance that your AuthRemoteDataSource uses
  final Dio _dio = DioClient.instance.dio;

  Future<Response> getAPI(String endpoint) async {
    try {
      return await _dio.get(endpoint);
    } on DioException catch (e) {
      throw ApiException(message: ApiException.handleError(e).message);
    }
  }

  Future<Response> postAPI(String endpoint, Map<String, dynamic> data) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioException catch (e) {
      throw ApiException(message: ApiException.handleError(e).message);
    }
  }

  Future<Response> putAPI(String endpoint, dynamic data) async {
    try {
      return await _dio.put(endpoint, data: data);
    } on DioException catch (e) {
      throw ApiException(message: ApiException.handleError(e).message);
    }
  }

  Future<Response> deleteAPI(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    try {
      return await _dio.delete(endpoint, data: data);
    } on DioException catch (e) {
      throw ApiException(message: ApiException.handleError(e).message);
    }
  }
}
