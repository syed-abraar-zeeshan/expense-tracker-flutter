import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException({required this.message, this.statusCode});

  @override
  String toString() {
    return message;
  }

  factory ApiException.fromDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return const ApiException(message: 'Connection timeout');

      case DioExceptionType.sendTimeout:
        return const ApiException(message: 'Send timeout');

      case DioExceptionType.receiveTimeout:
        return const ApiException(message: 'Receive timeout');

      case DioExceptionType.connectionError:
        return const ApiException(message: 'No internet connection');

      case DioExceptionType.badResponse:
        return ApiException(
          message: exception.response?.data['message'] ?? 'Server error',
          statusCode: exception.response?.statusCode,
        );

      default:
        return const ApiException(message: 'Something went wrong');
    }
  }
}
