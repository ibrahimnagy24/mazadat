# Notification Pusher Lifecycle Integration

This document explains how the notification pusher automatically manages its lifecycle based on user authentication and navigation states.

## 🔄 Automatic Lifecycle Management

The notification pusher now automatically:
- ✅ **Starts** when user enters the main app (navbar layout)
- ✅ **Stops** when user navigates to authentication screens
- ✅ **Stops** when app is closed or goes to background
- ✅ **Skips** for visitor users
- ✅ **Manages** app lifecycle state changes

## 🏗️ Integration Architecture

```
NavbarLayoutScreen
└── NotificationPusherWrapper
    ├── Auto-start on init
    ├── Auto-stop on dispose
    ├── App lifecycle monitoring
    └── User state monitoring
```

## 📱 Lifecycle Events

### Auto-Start Triggers:
1. **Navbar Entry**: When `CustomNavbarLayoutScreen` is initialized
2. **App Resume**: When app comes back from background (if user should be active)
3. **User Login**: When user successfully logs in as a real user (not visitor)

### Auto-Stop Triggers:
1. **Navbar Exit**: When `CustomNavbarLayoutScreen` is disposed
2. **App Background**: When app goes to background or becomes inactive
3. **User Logout**: When user logs out or becomes a visitor
4. **App Close**: When app is terminated

## 🎯 User State Logic

The service automatically checks:
- ✅ User must be logged in (`Utility.isUserLoggedIn()`)
- ✅ User data must be available (`mainAppBloc.globalUserData`)
- ✅ User must NOT be a visitor (`userType != UserType.visitor`)

## 🚀 Implementation

### Automatic Integration (Already Done)

The `NotificationPusherWrapper` is already integrated into `CustomNavbarLayoutScreen`:

```dart
// In CustomNavbarLayoutScreen
return NotificationPusherWrapper(
  child: BlocBuilder<NavbarLayoutCubit, NavbarLayoutState>(
    // ... existing navbar content
  ),
);
```

### Custom Notification Handling (Optional)

You can customize notification handling by providing callbacks:

```dart
NotificationPusherWrapper(
  onUserNotification: (state) {
    // Custom user notification handling
    print('📨 User: ${state.notificationData.title}');
    // Navigate to specific screen, show custom UI, etc.
  },
  onGeneralNotification: (state) {
    // Custom general notification handling
    print('📢 General: ${state.notificationData.title}');
    // Show custom notification UI, etc.
  },
  onConnectionStateChanged: (state) {
    // Monitor connection state
    print('🔄 Connection: ${state.state}');
  },
  child: YourWidget(),
)
```

## 📋 Default Behavior

If no custom handlers are provided, the wrapper shows default SnackBar notifications:
- 🔵 **User Notifications**: Blue SnackBar with user notification content
- 🟢 **General Notifications**: Green SnackBar with general notification content

## 🔧 Manual Control (If Needed)

You can still manually control the service:

```dart
// Manual start
await NotificationPusherService.autoStartOnNavbarEntry(context);

// Manual stop
await NotificationPusherService.autoStopOnNavbarExit();

// Check if should be active
bool shouldStart = NotificationPusherService.shouldBeActive();

// Check current status
bool isRunning = NotificationPusherService.isInitialized;
```

## 📊 Logging

The service provides detailed logging for lifecycle events:

- 🏠 `Auto-starting on navbar entry`
- 🚪 `Auto-stopping on navbar exit`
- 👤 `User is visitor, skipping auto-start`
- ✅ `Already initialized, skipping auto-start`
- 🚀 `Auto-started successfully for user: {userId}`
- 🛑 `Auto-stopped successfully`

## 🔍 Debugging

To debug lifecycle issues, look for these log prefixes:
- `[NOTIFICATION_PUSHER_SERVICE]` - Service lifecycle logs
- `[NOTIFICATION_PUSHER]` - Core pusher logs
- `[NOTIFICATION]` - Event processing logs

## 🎯 User Flow Examples

### Logged-in User Flow:
1. User opens app → Navbar loads → Service auto-starts ✅
2. User navigates within app → Service stays active ✅
3. User minimizes app → Service auto-stops 🛑
4. User returns to app → Service auto-starts ✅
5. User logs out → Service auto-stops 🛑

### Visitor User Flow:
1. Visitor opens app → Navbar loads → Service skips start (visitor) 👤
2. Visitor navigates → No service activity ⏸️
3. Visitor becomes real user → Service auto-starts ✅

### Authentication Flow:
1. User on auth screen → No service activity ⏸️
2. User logs in → Navigates to navbar → Service auto-starts ✅
3. User logs out → Returns to auth → Service auto-stops 🛑

## ⚠️ Important Notes

1. **No Manual Initialization Needed**: The service automatically starts when appropriate
2. **Visitor Safety**: Visitors never trigger the notification service
3. **Memory Management**: Service properly cleans up when not needed
4. **State Persistence**: Service remembers user state across app lifecycle
5. **Error Handling**: All lifecycle operations are wrapped in try-catch blocks

The notification pusher now seamlessly integrates with your app's navigation and authentication flow! 🎉
