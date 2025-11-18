# FCM Notification Module

A comprehensive Firebase Cloud Messaging (FCM) notification module for the Mazadat Flutter app that handles all notification scenarios including foreground, background, and terminated app states.

## Features

- ✅ **Complete Notification Handling**: Foreground, background, and terminated app states
- ✅ **In-App Notifications**: Beautiful overlay notifications when app is active
- ✅ **Smart Navigation**: Automatic navigation based on notification type and data
- ✅ **Local Notifications**: Cross-platform local notification support
- ✅ **Topic Management**: Subscribe/unsubscribe from notification topics
- ✅ **Custom Actions**: Support for custom notification actions
- ✅ **Type-Safe**: Comprehensive notification model with proper typing
- ✅ **Easy Integration**: Simple setup and usage

## Module Structure

```
lib/core/services/fcm_notification/
├── fcm_notification_service.dart      # Main service class
├── fcm_notification_handler.dart      # Notification handling logic
├── fcm_integration_helper.dart        # Integration helper methods
├── notification_types.dart            # Constants and types
├── models/
│   └── notification_model.dart        # Notification data model
└── ui/
    └── in_app_notification_widget.dart # In-app notification UI
```

## Quick Setup

### 1. Initialize in main.dart

```dart
import 'core/services/fcm_notification/fcm_integration_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize FCM
  await FCMIntegrationHelper.initializeFCM();
  
  runApp(MyApp());
}
```

### 2. Subscribe to Topics (after user login)

```dart
// Subscribe to user-specific and general topics
await FCMIntegrationHelper.subscribeToUserTopics(userId);
```

### 3. Unsubscribe on Logout

```dart
// Unsubscribe from all topics
await FCMIntegrationHelper.unsubscribeFromAllTopics(userId);
```

## Usage Examples

### Get FCM Token

```dart
String? token = FCMIntegrationHelper.getFCMToken();
if (token != null) {
  // Send token to your server
  await FCMIntegrationHelper.sendTokenToServer(token);
}
```

### Clear Notifications

```dart
// Clear all notifications
await FCMIntegrationHelper.clearAllNotifications();

// Get pending notifications count
int count = await FCMIntegrationHelper.getPendingNotificationsCount();
```

### Check Initialization Status

```dart
bool isReady = FCMIntegrationHelper.isInitialized();
```

## Notification Types

The module supports various notification types with automatic handling:

- **auction**: Navigate to auction details
- **order**: Navigate to my purchases
- **payment**: Navigate to wallet
- **general**: Navigate to specified screen or home
- **promotion**: Navigate to promotions

## Notification Data Structure

```json
{
  "notification": {
    "title": "New Auction Available",
    "body": "Check out this amazing auction!"
  },
  "data": {
    "type": "auction",
    "action": "navigate",
    "auction_id": "123",
    "target_screen": "auction_details"
  }
}
```

## Custom Actions

The module supports custom actions:

- **open_url**: Open URL in browser
- **show_dialog**: Show custom dialog
- **refresh_data**: Refresh app data
- **navigate**: Navigate to specific screen

## In-App Notifications

When the app is in foreground, notifications are displayed as beautiful overlay widgets with:

- Smooth slide-in animation
- Auto-dismiss after 4 seconds
- Tap to navigate
- Swipe to dismiss
- Type-based icons and colors

## Background Message Handling

Background messages are handled by the `firebaseMessagingBackgroundHandler` function which:

- Processes notification data
- Performs background tasks
- Cannot show UI or navigate (iOS/Android limitation)

## Topic Management

### Default Topics

- `general_notifications`: General app notifications
- `promotions`: Promotional offers
- `app_updates`: App update notifications
- `auction_alerts`: Auction-related alerts
- `user_{userId}`: User-specific notifications

### Custom Topics

```dart
// Subscribe to custom topic
await FCMNotificationService.instance.subscribeToTopic('custom_topic');

// Unsubscribe from custom topic
await FCMNotificationService.instance.unsubscribeFromTopic('custom_topic');
```

## Error Handling

The module includes comprehensive error handling:

- Graceful fallbacks for missing permissions
- Logging for debugging
- Safe navigation handling
- Null safety throughout

## Dependencies Required

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  firebase_messaging: ^14.7.9
  flutter_local_notifications: ^16.3.0
```

## Platform Configuration

### Android

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<meta-data
  android:name="com.google.firebase.messaging.default_notification_channel_id"
  android:value="high_importance_channel" />
```

### iOS

Add notification capability in `ios/Runner/Runner.entitlements`:

```xml
<key>aps-environment</key>
<string>development</string>
```

## Testing

### Test Notification Payload

```json
{
  "to": "FCM_TOKEN_HERE",
  "notification": {
    "title": "Test Notification",
    "body": "This is a test notification"
  },
  "data": {
    "type": "auction",
    "auction_id": "123",
    "action": "navigate"
  }
}
```

## Best Practices

1. **Always check initialization**: Use `FCMIntegrationHelper.isInitialized()`
2. **Handle token refresh**: Update server when token changes
3. **Manage topics properly**: Subscribe on login, unsubscribe on logout
4. **Test all scenarios**: Foreground, background, and terminated states
5. **Handle permissions**: Request permissions gracefully
6. **Use appropriate channels**: Different channels for different notification types

## Troubleshooting

### Common Issues

1. **Notifications not received**: Check FCM token and server configuration
2. **Background handler not working**: Ensure function is top-level
3. **Navigation not working**: Check route definitions and context availability
4. **Permissions denied**: Handle permission requests properly

### Debug Tips

- Check console logs for FCM-related messages
- Verify Firebase project configuration
- Test with Firebase Console first
- Check device notification settings

## Integration Checklist

- [ ] Firebase project configured
- [ ] FCM dependencies added
- [ ] Platform-specific configuration done
- [ ] FCM initialized in main.dart
- [ ] Background handler registered
- [ ] Topic subscriptions implemented
- [ ] Navigation routes configured
- [ ] Testing completed for all scenarios

## Support

For issues or questions regarding this FCM notification module, please check:

1. Firebase documentation
2. Flutter local notifications documentation
3. Platform-specific notification guidelines
4. This module's implementation details
