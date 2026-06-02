import 'package:dio/dio.dart';
import 'package:expense_flow/core/constants/api_constants.dart';
import 'package:expense_flow/core/network/api_interceptor.dart';

class DioClient {
  DioClient._();
  static final DioClient instance = DioClient._();

  late final Dio _dio;
  Dio get dio => _dio;

  void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl, // Bound directly to your constants file
        connectTimeout: const Duration(
          seconds: 30,
        ), // 30s is standard for production stability
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    // Chain your interceptor modules sequentially
    _dio.interceptors.addAll([
      ApiInterceptor(), // Your cleanly separated custom interceptor
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }
}
