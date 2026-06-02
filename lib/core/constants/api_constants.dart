class ApiConstants {
  ApiConstants._();

  // Core Backend Base Server Environments
  static const String baseUrl =
      'https://easing-flanked-molar.ngrok-free.dev/api';
  // Tip: For physical device testing, use your machine's IP (e.g., 'http://192.168.1.X:5000/api')

  // Authentication Endpoints
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String profile = '/auth/me';
}
