import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// Import your local storage source file here:
import 'package:expense_flow/features/auth/data/datasources/auth_local_data_source.dart';

class ApiInterceptor extends Interceptor {
  // 1. Instantiate the secure storage data source
  final AuthLocalDataSource _localDataSource = AuthLocalDataSource();

  // 2. Fix the hook to fetch the real encrypted token from the disk
  Future<String?> _getAccessToken() async {
    return await _localDataSource.getAccessToken();
  }

  // 3. Fix the hook to wipe the secure storage when the token expires
  Future<void> _handleSessionExpiry() async {
    await _localDataSource.clearAccessToken();

    // TODO: Trigger your Riverpod navigation state to route
    // the user back to the visual Login Screen cleanly.
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';

    // This now dynamically injects the securely saved token!
    final token = await _getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    if (kDebugMode) {
      print('🟡 REQUEST [${options.method}] ──> ${options.uri}');
      if (options.data != null) print('📦 Payload: ${options.data}');
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print(
        '🟢 RESPONSE [${response.statusCode}] <── ${response.requestOptions.uri}',
      );
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    // If the server explicitly responds with a 401 Unauthorized
    if (statusCode == 401) {
      if (kDebugMode) {
        print('🔴 UNAUTHORIZED [401] ──> Evicting secure session.');
      }

      // Clear out the stale encrypted keys instantly
      await _handleSessionExpiry();
    }

    return handler.next(err);
  }
}
