class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final int statusCode;

  const ApiResponse({
    required this.success,
    required this.message,
    required this.statusCode,
    this.data,
  });
}
