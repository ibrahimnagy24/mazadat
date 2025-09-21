import 'package:firebase_messaging/firebase_messaging.dart';
import '../../utils/utility.dart';
import 'fcm_notification_service.dart';

/// Helper class for integrating FCM notifications into the app
class FCMIntegrationHelper {
  /// Initialize FCM notifications in the app
  static Future<void> initializeFCM() async {
    try {
      // Set background message handler
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      
      // Initialize FCM service
      await FCMNotificationService.instance.initialize();
      
      cprint('FCM Integration completed successfully');
    } catch (e) {
      cprint('Error initializing FCM: $e');
    }
  }

  /// Get FCM token for sending to server
  static String? getFCMToken() {
    return FCMNotificationService.instance.fcmToken;
  }

  /// Subscribe to topics (call after user login)
  static Future<void> subscribeToUserTopics(int userId) async {
    try {
      // Subscribe to user-specific topic
      await FCMNotificationService.instance.subscribeToTopic('user_$userId');
      
      // Subscribe to general topics
      await FCMIntegrationHelper.subscribeToGeneralTopics();
      
      cprint('Subscribed to user topics for user: $userId');
    } catch (e) {
      cprint('Error subscribing to user topics: $e');
    }
  }

  /// Subscribe to general topics
  static Future<void> subscribeToGeneralTopics() async {
    try {
      final topics = [
        'general_notifications',
        'promotions',
        'app_updates',
        'auction_alerts',
      ];

      for (final topic in topics) {
        await FCMNotificationService.instance.subscribeToTopic(topic);
      }
      
      cprint('Subscribed to general topics');
    } catch (e) {
      cprint('Error subscribing to general topics: $e');
    }
  }

  /// Unsubscribe from user topics (call on logout)
  static Future<void> unsubscribeFromUserTopics(int userId) async {
    try {
      // Unsubscribe from user-specific topic
      await FCMNotificationService.instance.unsubscribeFromTopic('user_$userId');
      
      cprint('Unsubscribed from user topics for user: $userId');
    } catch (e) {
      cprint('Error unsubscribing from user topics: $e');
    }
  }

  /// Unsubscribe from all topics (call on logout)
  static Future<void> unsubscribeFromAllTopics(int userId) async {
    try {
      // Unsubscribe from user-specific topic
      await FCMIntegrationHelper.unsubscribeFromUserTopics(userId);
      
      // Unsubscribe from general topics
      final topics = [
        'general_notifications',
        'promotions',
        'app_updates',
        'auction_alerts',
      ];

      for (final topic in topics) {
        await FCMNotificationService.instance.unsubscribeFromTopic(topic);
      }
      
      cprint('Unsubscribed from all topics');
    } catch (e) {
      cprint('Error unsubscribing from all topics: $e');
    }
  }

  /// Send FCM token to server
  static Future<void> sendTokenToServer(String token) async {
    try {
      // TODO: Implement API call to send token to your server
      // Example:
      // await ApiService.sendFCMToken(token);
      
      cprint('FCM token sent to server: $token');
    } catch (e) {
      cprint('Error sending FCM token to server: $e');
    }
  }

  /// Handle token refresh (call this when token changes)
  static Future<void> handleTokenRefresh(String newToken) async {
    try {
      // Send new token to server
      await sendTokenToServer(newToken);
      
      cprint('FCM token refreshed and sent to server');
    } catch (e) {
      cprint('Error handling token refresh: $e');
    }
  }

  /// Clear all notifications
  static Future<void> clearAllNotifications() async {
    await FCMNotificationService.instance.clearAllNotifications();
  }

  /// Check if FCM is initialized
  static bool isInitialized() {
    return FCMNotificationService.instance.isInitialized;
  }

  /// Get pending notifications count
  static Future<int> getPendingNotificationsCount() async {
    final notifications = await FCMNotificationService.instance.getPendingNotifications();
    return notifications.length;
  }
}
