import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() => "ApiException: $message (Status Code: $statusCode)";

  // Translates messy DioExceptions into readable, production-grade application exceptions
  static ApiException handleError(DioException error) {
    final response = error.response;

    if (response != null) {
      final statusCode = response.statusCode;
      final data = response.data;

      // Attempt to extract a clear validation or server error message from your Node.js response data maps
      String responseMessage = '';
      if (data is Map<String, dynamic>) {
        responseMessage = data['message']?.toString() ?? '';
      }

      switch (statusCode) {
        case 400:
          return ApiException(
            message: responseMessage.isNotEmpty
                ? responseMessage
                : "Bad Request. Please check your inputs.",
            statusCode: 400,
          );
        case 401:
          return ApiException(
            message: responseMessage.isNotEmpty
                ? responseMessage
                : "Unauthorized access. Please log in again.",
            statusCode: 401,
          );
        case 403:
          return ApiException(
            message: responseMessage.isNotEmpty
                ? responseMessage
                : "Forbidden. You do not have permission to access this resource.",
            statusCode: 403,
          );
        case 404:
          return ApiException(
            message: responseMessage.isNotEmpty
                ? responseMessage
                : "Requested resource not found.",
            statusCode: 404,
          );
        case 500:
          return ApiException(
            message: responseMessage.isNotEmpty
                ? responseMessage
                : "Internal Server Error. Please try again later.",
            statusCode: 500,
          );
        case 503:
          return ApiException(
            message: responseMessage.isNotEmpty
                ? responseMessage
                : "Service temporarily unavailable.",
            statusCode: 503,
          );
        default:
          return ApiException(
            message: responseMessage.isNotEmpty
                ? responseMessage
                : "Unexpected network error occurred ($statusCode).",
            statusCode: statusCode,
          );
      }
    } else {
      // Handles scenarios where the server was never reached (timeouts, bad connection)
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ApiException(
            message:
                "Connection timed out. Please check your internet connection.",
          );
        case DioExceptionType.sendTimeout:
          return ApiException(message: "Request send timeout. Try again.");
        case DioExceptionType.receiveTimeout:
          return ApiException(message: "Server response timeout. Try again.");
        case DioExceptionType.cancel:
          return ApiException(message: "Server request was cancelled.");
        case DioExceptionType.connectionError:
          return ApiException(
            message:
                "No internet connection detected or server is unreachable.",
          );
        default:
          return ApiException(
            message: "A network error occurred. Please verify your connection.",
          );
      }
    }
  }
}
