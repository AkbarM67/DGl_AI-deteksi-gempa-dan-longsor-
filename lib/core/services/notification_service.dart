import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../models/notification_model.dart';
import '../../features/notification/notification_history_page.dart';
import 'notification_storage.dart';

// Handler untuk background messages
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Background message: ${message.notification?.title}');
}

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications = 
      FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static GlobalKey<NavigatorState>? _navigatorKey;

  static Future<void> initialize(GlobalKey<NavigatorState> navigatorKey) async {
    _navigatorKey = navigatorKey;
    
    // Setup background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
    // Initialize local notifications
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        print('Notification clicked: ${details.payload}');
        _navigateToNotificationHistory();
      },
    );

    // Create notification channel for Android
    const androidChannel = AndroidNotificationChannel(
      'emergency_channel',
      'Emergency Alerts',
      description: 'Critical emergency notifications',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    // Request permissions for notifications
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      criticalAlert: true,
    );

    print('Notification permission: ${settings.authorizationStatus}');

    // Get FCM token
    final token = await _messaging.getToken();
    print('FCM Token: $token');

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message: ${message.notification?.title}');
      
      if (message.notification != null) {
        showEmergencyAlert(
          title: message.notification!.title ?? 'Peringatan',
          body: message.notification!.body ?? '',
        );
      }
    });
    
    // Handle notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification opened app: ${message.notification?.title}');
      _navigateToNotificationHistory();
    });
  }
  
  static void _navigateToNotificationHistory() {
    if (_navigatorKey?.currentContext != null) {
      Navigator.push(
        _navigatorKey!.currentContext!,
        MaterialPageRoute(
          builder: (context) => const NotificationHistoryPage(),
        ),
      );
    }
  }

  static Future<void> showEmergencyAlert({
    required String title,
    required String body,
    String riskLevel = 'INFO',
  }) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'emergency_channel',
        'Emergency Alerts',
        channelDescription: 'Critical emergency notifications',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
        enableVibration: true,
        playSound: true,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      
      await _notifications.show(
        notificationId,
        title,
        body,
        details,
      );

      // Save to local storage
      try {
        final notification = NotificationModel(
          id: notificationId.toString(),
          title: title,
          body: body,
          riskLevel: riskLevel,
          timestamp: DateTime.now(),
        );
        await NotificationStorage.saveNotification(notification);
      } catch (e) {
        print('Failed to save notification to storage: $e');
      }
    } catch (e) {
      print('Failed to show notification: $e');
    }
  }

  static Future<void> simulateEarthquakeAlert() async {
    await showEmergencyAlert(
      title: '🚨 PERINGATAN GEMPA',
      body: 'Simulasi: Sistem deteksi risiko tinggi. Bersiaplah untuk evakuasi!',
    );
  }
}