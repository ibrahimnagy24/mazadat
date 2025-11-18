import 'package:flutter/material.dart';
import '../../navigation/custom_navigation.dart';
import '../toast_service.dart';
import 'notification_pusher_service.dart';
import 'notification_pusher_state.dart';

/// A wrapper widget that automatically manages notification pusher lifecycle
/// for the main app area (navbar layout)
class NotificationPusherWrapper extends StatefulWidget {
  final Widget child;
  final Function(UserNotificationReceived)? onUserNotification;
  final Function(GeneralNotificationReceived)? onGeneralNotification;
  final Function(NotificationPusherConnectionStateChanged)?
      onConnectionStateChanged;

  const NotificationPusherWrapper({
    super.key,
    required this.child,
    this.onUserNotification,
    this.onGeneralNotification,
    this.onConnectionStateChanged,
  });

  @override
  State<NotificationPusherWrapper> createState() =>
      _NotificationPusherWrapperState();
}

class _NotificationPusherWrapperState extends State<NotificationPusherWrapper>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Auto-start when entering navbar layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationPusherService.autoStartOnNavbarEntry(context);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Auto-stop when leaving navbar layout
    NotificationPusherService.autoStopOnNavbarExit();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        // App came back to foreground, restart if should be active
        if (NotificationPusherService.shouldBeActive() &&
            !NotificationPusherService.isInitialized) {
          NotificationPusherService.autoStartOnNavbarEntry(context);
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        // App going to background or closing, stop the service
        NotificationPusherService.autoStopOnNavbarExit();
        break;
      case AppLifecycleState.inactive:
        // App becoming inactive, but don't stop yet
        break;
      case AppLifecycleState.hidden:
        // App is hidden, stop the service
        NotificationPusherService.autoStopOnNavbarExit();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationPusherService.createLifecycleAwareListener(
      onUserNotification:
          widget.onUserNotification ?? _defaultUserNotificationHandler,
      onGeneralNotification:
          widget.onGeneralNotification ?? _defaultGeneralNotificationHandler,
      onConnectionStateChanged: widget.onConnectionStateChanged,
      child: widget.child,
    );
  }

  void _defaultUserNotificationHandler(UserNotificationReceived state) {
    ToastService.showCustom(
      message: state.notificationData.title ?? 'no title',
      context: CustomNavigator.context,
      toastStatusType: ToastStatusType.success,
    );
    // Default handler - show a snackbar
    // ScaffoldMessenger.of(CustomNavigator.context).showSnackBar(
    //   SnackBar(
    //     content:
    //         Text('📨 ${state.notificationData.title ?? 'New Notification'}'),
    //     backgroundColor: Colors.blue,
    //     duration: const Duration(seconds: 3),
    //   ),
    // );
  }

  void _defaultGeneralNotificationHandler(GeneralNotificationReceived state) {
    ToastService.showCustom(
      message: state.notificationData.title ?? 'no title',
      context: CustomNavigator.context,
      toastStatusType: ToastStatusType.success,
    );

    // ScaffoldMessenger.of(CustomNavigator.context).showSnackBar(
    //   SnackBar(
    //     content: Text(
    //         '📢 ${state.notificationData.title ?? 'General Notification'}'),
    //     backgroundColor: Colors.green,
    //     duration: const Duration(seconds: 3),
    //   ),
    // );
  }
}
