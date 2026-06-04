import 'package:dio/dio.dart';
import 'package:expense_flow/core/constants/api_constants.dart';
import 'package:expense_flow/core/network/api_interceptor.dart';
import 'package:expense_flow/core/storage/secure_storage_service.dart';

class ApiClient {
  ApiClient._();

  static Dio create(SecureStorageService storage) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(ApiInterceptor(storage));

    return dio;
  }
}
