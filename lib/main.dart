import 'package:expense_flow/app/app.dart';
import 'package:expense_flow/core/services/local_notification_service.dart';
import 'package:expense_flow/core/services/notification_service.dart';
import 'package:expense_flow/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await NotificationService().initialize();
  await LocalNotificationService().initialize();
  runApp(ProviderScope(child: ExpenseFlowApp()));
}
