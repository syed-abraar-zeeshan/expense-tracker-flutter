class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://easing-flanked-molar.ngrok-free.dev/api';

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String profile = '/auth/profile';
  static const String dashboard = '/dashboard';
  static const String categories = '/categories';
  static const String expenses = '/expenses';
  static const String registerFCMToken = '/fcm/register';
  static const String sendNotification = '/fcm/send';
}
