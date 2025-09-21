import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../utils/utility.dart';
import 'fcm_notification_handler.dart';
import 'models/notification_model.dart';

class FCMNotificationService {
  static final FCMNotificationService _instance = FCMNotificationService._internal();
  factory FCMNotificationService() => _instance;
  FCMNotificationService._internal();

  static FCMNotificationService get instance => _instance;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  
  bool _isInitialized = false;
  String? _fcmToken;
  
  // Getters
  String? get fcmToken => _fcmToken;
  bool get isInitialized => _isInitialized;

  /// Initialize FCM service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Request permissions
      await _requestPermissions();
      
      // Initialize local notifications
      await _initializeLocalNotifications();
      
      // Get FCM token
      await _getFCMToken();
      
      // Setup message handlers
      await _setupMessageHandlers();
      
      _isInitialized = true;
      cprint('FCM Notification Service initialized successfully');
    } catch (e) {
      cprint('Error initializing FCM Notification Service: $e');
    }
  }

  /// Request notification permissions
  Future<void> _requestPermissions() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    cprint('FCM Permission status: ${settings.authorizationStatus}');
  }

  /// Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
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

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create notification channel for Android
    if (Platform.isAndroid) {
      await _createNotificationChannel();
    }
  }

  /// Create notification channel for Android
  Future<void> _createNotificationChannel() async {
    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      playSound: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Get FCM token
  Future<void> _getFCMToken() async {
    try {
      _fcmToken = await _firebaseMessaging.getToken();
      cprint('FCM Token: $_fcmToken');
      
      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((token) {
        _fcmToken = token;
        cprint('FCM Token refreshed: $token');
        // TODO: Send updated token to your server
      });
    } catch (e) {
      cprint('Error getting FCM token: $e');
    }
  }

  /// Setup message handlers
  Future<void> _setupMessageHandlers() async {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    
    // Handle background messages (when app is in background but not terminated)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
    
    // Handle messages when app is opened from terminated state
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageOpenedApp(initialMessage);
    }
  }

  /// Handle foreground messages (when app is active)
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    cprint('Received foreground message: ${message.messageId}');
    
    final notificationModel = NotificationModel.fromRemoteMessage(message);
    
    // Show local notification
    await _showLocalNotification(notificationModel);
    
    // Handle notification action
    FCMNotificationHandler.handleNotification(notificationModel);
  }

  /// Handle messages when app is opened from background or terminated state
  Future<void> _handleMessageOpenedApp(RemoteMessage message) async {
    cprint('App opened from notification: ${message.messageId}');
    
    final notificationModel = NotificationModel.fromRemoteMessage(message);
    
    // Handle notification action with delay to ensure app is ready
    Future.delayed(const Duration(milliseconds: 500), () {
      FCMNotificationHandler.handleNotification(notificationModel);
    });
  }

  /// Show local notification
  Future<void> _showLocalNotification(NotificationModel notification) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.high,
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

      const notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _localNotifications.show(
        notification.id ?? DateTime.now().millisecondsSinceEpoch ~/ 1000,
        notification.title,
        notification.body,
        notificationDetails,
        payload: jsonEncode(notification.toJson()),
      );
    } catch (e) {
      cprint('Error showing local notification: $e');
    }
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    cprint('Notification tapped: ${response.payload}');
    
    if (response.payload != null) {
      try {
        final data = jsonDecode(response.payload!);
        final notification = NotificationModel.fromJson(data);
        FCMNotificationHandler.handleNotification(notification);
      } catch (e) {
        cprint('Error parsing notification payload: $e');
      }
    }
  }

  /// Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      cprint('Subscribed to topic: $topic');
    } catch (e) {
      cprint('Error subscribing to topic $topic: $e');
    }
  }

  /// Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      cprint('Unsubscribed from topic: $topic');
    } catch (e) {
      cprint('Error unsubscribing from topic $topic: $e');
    }
  }

  /// Clear all notifications
  Future<void> clearAllNotifications() async {
    await _localNotifications.cancelAll();
  }

  /// Clear specific notification
  Future<void> clearNotification(int id) async {
    await _localNotifications.cancel(id);
  }

  /// Get pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _localNotifications.pendingNotificationRequests();
  }

  /// Dispose resources
  void dispose() {
    _isInitialized = false;
  }
}

/// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  cprint('Received background message: ${message.messageId}');
  
  // Initialize Firebase if not already done
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  final notificationModel = NotificationModel.fromRemoteMessage(message);
  
  // Handle background notification
  // Note: You can't show UI or navigate in background handler
  // You can only perform data processing, local storage operations, etc.
  
  cprint('Background notification processed: ${notificationModel.title}');
}
