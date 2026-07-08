import 'package:expense_flow/core/services/local_notification_service.dart';
import 'package:expense_flow/core/services/notification_navigation_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer' as developer;

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  developer.log('Background message received');
  developer.log('Title: ${message.notification?.title}');
  developer.log('Body: ${message.notification?.body}');
}

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    NotificationSettings settings = await _messaging.requestPermission();
    developer.log('Permission granted: ${settings.authorizationStatus}');

    final token = await _messaging.getToken();
    developer.log('FCM Token: $token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final notification = message.notification;

      if (notification != null) {
        await LocalNotificationService().showNotifications(
          title: notification.title ?? "",
          body: notification.body ?? "",
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      developer.log('Notification tapped!');
      developer.log('Title: ${message.notification?.title}');
      developer.log('Body: ${message.notification?.body}');
      _handleNotification(message);
    });

    final RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();

    if (initialMessage != null) {
      developer.log('App opened from terminated state!');
      developer.log('Title: ${initialMessage.notification?.title}');
      developer.log('Body: ${initialMessage.notification?.body}');
      _handleNotification(initialMessage);
    }
  }

  Future<void> _handleNotification(RemoteMessage message) async {
    final expenseId = message.data["expenseId"];

    if (expenseId != null) {
      await NotificationNavigationService().openExpense(expenseId);
    }
  }
}
