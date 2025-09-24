# Notification Pusher Service

This module provides real-time notification functionality using Pusher channels for the Mazadat app. It's designed to handle user-specific and general notifications through WebSocket connections and runs globally throughout the entire application.

## Features

- **Global Service**: Runs throughout the entire application via BlocProvider
- Real-time notification delivery via Pusher
- Support for two event types:
  - `DEV_USER_NOTIFICATION`: General user notifications
  - `SEND_NOTIFICATION_{userId}`: User-specific notifications
- Comprehensive state management with BLoC pattern
- Automatic connection handling and reconnection
- Easy-to-use service helper for global access
- Detailed logging for debugging

## Architecture

The module follows the same architecture as the existing auction pusher service:

```
lib/core/services/notification_pusher/
├── notification_pusher_cubit.dart      # Main cubit handling Pusher connection and events
├── notification_pusher_state.dart      # All possible states for the notification pusher
├── notification_event_model.dart       # Model for parsing notification event data
├── notification_pusher_service.dart    # Global service helper for easy access
├── usage_example.dart                  # Complete usage example
└── README.md                          # This documentation
```

## Global Setup

The service is automatically available throughout the app via the provider system in `providers.dart`:

```dart
BlocProvider<NotificationPusherCubit>(
    create: (_) => NotificationPusherCubit()),
```

## Usage

### 1. Global Initialization (Recommended)

Use the `NotificationPusherService` helper for easy global access:

```dart
// Initialize with specific user ID
await NotificationPusherService.initializeGlobal(context, "12345");

// Initialize with current user from mainAppBloc
await NotificationPusherService.initializeWithCurrentUser(context);
```

### 2. Direct Cubit Access

You can also access the cubit directly:

```dart
// Get the cubit instance
final notificationPusher = context.read<NotificationPusherCubit>();

// Initialize with user ID
notificationPusher.init(userId);
```

### 3. Listening to Notification Events

#### Option A: Using the Global Service Helper (Recommended)

```dart
NotificationPusherService.createNotificationListener(
  onUserNotification: (state) {
    // Handle user notification
    print('📨 User Notification: ${state.notificationData.title}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User: ${state.notificationData.title}')),
    );
  },
  onGeneralNotification: (state) {
    // Handle general notification
    print('📨 General Notification: ${state.notificationData.title}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('General: ${state.notificationData.title}')),
    );
  },
  onConnectionStateChanged: (state) {
    print('🔄 Connection: ${state.state}');
  },
  child: YourWidget(),
)
```

#### Option B: Using BlocListener Directly

```dart
BlocListener<NotificationPusherCubit, NotificationPusherState>(
  listener: (context, state) {
    if (state is UserNotificationReceived) {
      // Handle user notification
      print('User notification: ${state.notificationData.title}');
    } else if (state is GeneralNotificationReceived) {
      // Handle general notification
      print('General notification: ${state.notificationData.title}');
    }
  },
  child: YourWidget(),
)
```

### 3. Connection State Monitoring

Monitor the connection state for debugging or UI feedback:

```dart
BlocBuilder<NotificationPusherCubit, NotificationPusherState>(
  builder: (context, state) {
    if (state is NotificationPusherConnectionStateChanged) {
      switch (state.state) {
        case NotificationPusherConnectionState.CONNECTED:
          return Text('Connected to notifications');
        case NotificationPusherConnectionState.CONNECTING:
          return Text('Connecting...');
        case NotificationPusherConnectionState.DISCONNECTED:
          return Text('Disconnected');
        // Handle other states...
      }
    }
    return Container();
  },
)
```

## Event Types

### DEV_USER_NOTIFICATION
- General user notifications
- Triggered for all users subscribed to the channel
- Handled by `_userNotificationReceived` method

### SEND_NOTIFICATION_{userId}
- User-specific notifications
- Only triggered for the specific user ID
- Handled by `_generalNotificationReceived` method

## Notification Data Structure

The `NotificationEventModel` expects the following JSON structure:

```json
{
  "title": "Notification Title",
  "body": "Notification body text",
  "type": "notification_type",
  "data": {
    // Additional custom data
  }
}
```

## States

The module provides comprehensive state management:

### Connection States
- `NotificationPusherInitial`
- `NotificationPusherInitLoading`
- `NotificationPusherInitSuccess`
- `NotificationPusherInitError`
- `NotificationPusherConnectionLoading`
- `NotificationPusherConnectionSuccess`
- `NotificationPusherConnectionError`
- `NotificationPusherSubscriptionLoading`
- `NotificationPusherSubscriptionSuccess`
- `NotificationPusherSubscriptionError`
- `NotificationPusherConnectionStateChanged`

### Event States
- `UserNotificationReceived`
- `GeneralNotificationReceived`

## Configuration

The service uses the same Pusher configuration as the auction service:
- API Key: `AppConfig.PUSHER_API_KEY`
- Cluster: `AppConfig.PUSHER_API_CLUSTER`
- Auth Endpoint: `AppConfig.PUSHER_AUTH_ENDPOINT`
- Channel: `DEV_USER_NOTIFICATION`

## Logging

The service provides detailed logging with the `[NOTIFICATION_PUSHER]` prefix for easy debugging:

- 🚀 Initialization logs
- 🔔 Notification event logs
- 📄 Data parsing logs
- ✅ Success logs
- ❌ Error logs
- 🔄 Connection state logs

### 4. Global Service Management

The `NotificationPusherService` provides several utility methods for managing the global service:

```dart
// Check if service is initialized
bool isReady = NotificationPusherService.isInitialized;

// Get direct access to the cubit instance
NotificationPusherCubit? cubit = NotificationPusherService.instance;

// Disconnect the service (useful for logout)
await NotificationPusherService.disconnect();

// Reinitialize with new user (useful for user switching)
await NotificationPusherService.reinitialize(context, "newUserId");
```

## Integration with Providers

The service is automatically registered in `providers.dart` and available throughout the app:

```dart
BlocProvider<NotificationPusherCubit>(
    create: (_) => NotificationPusherCubit()),
```

## Typical Integration Flow

1. **App Launch**: Service is available globally via BlocProvider
2. **User Login**: Initialize the service with user ID
3. **Throughout App**: Listen to notifications in any screen
4. **User Logout**: Disconnect the service
5. **User Switch**: Reinitialize with new user ID

## Future Enhancements

When the notification response structure is finalized:
1. Update `NotificationEventModel` with the correct fields
2. Enhance event handling methods with proper data parsing
3. Add any additional notification types as needed
4. Implement notification-specific actions (navigation, etc.)

## Notes

- The service automatically handles connection management
- Proper cleanup is performed when the cubit is closed
- All events not matching the expected patterns are safely ignored
- The service is designed to be resilient and handle network interruptions
