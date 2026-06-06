import 'package:dio/dio.dart';
import 'package:expense_flow/core/storage/secure_storage_service.dart';
import 'package:flutter/foundation.dart';

class ApiInterceptor extends Interceptor {
  final SecureStorageService _storage;

  ApiInterceptor(this._storage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    } else {
      options.headers.remove('Authorization');
    }

    if (kDebugMode) {
      debugPrint('REQUEST => ${options.method} ${options.uri}');
      debugPrint('HEADERS => ${options.headers}');
      debugPrint('BODY => ${options.data}');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('STATUS => ${response.statusCode}');

      debugPrint('RESPONSE => ${response.data}');
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('ERROR => ${err.message}');
    }

    handler.next(err);
  }
}
