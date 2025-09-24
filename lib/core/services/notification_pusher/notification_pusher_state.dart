import 'notification_event_model.dart';

sealed class NotificationPusherState {
  const NotificationPusherState();
}

final class NotificationPusherInitial extends NotificationPusherState {}

final class NotificationPusherInitLoading extends NotificationPusherState {}

final class NotificationPusherInitSuccess extends NotificationPusherState {}

final class NotificationPusherInitError extends NotificationPusherState {
  final String error;
  const NotificationPusherInitError(this.error);
}

final class NotificationPusherConnectionLoading extends NotificationPusherState {}

final class NotificationPusherConnectionSuccess extends NotificationPusherState {}

final class NotificationPusherConnectionError extends NotificationPusherState {
  final String error;
  const NotificationPusherConnectionError(this.error);
}

final class NotificationPusherSubscriptionLoading extends NotificationPusherState {}

final class NotificationPusherSubscriptionSuccess extends NotificationPusherState {}

final class NotificationPusherSubscriptionError extends NotificationPusherState {
  final String error;
  const NotificationPusherSubscriptionError(this.error);
}

final class NotificationPusherConnectionStateChanged extends NotificationPusherState {
  final NotificationPusherConnectionState state;
  const NotificationPusherConnectionStateChanged(this.state);
}

final class UserNotificationReceived extends NotificationPusherState {
  final String userId;
  final NotificationEventModel notificationData;

  const UserNotificationReceived({
    required this.userId,
    required this.notificationData,
  });
}

final class GeneralNotificationReceived extends NotificationPusherState {
  final String userId;
  final NotificationEventModel notificationData;

  const GeneralNotificationReceived({
    required this.userId,
    required this.notificationData,
  });
}

enum NotificationPusherConnectionState {
  RECONNECTING,
  DISCONNECTED,
  CONNECTING,
  CONNECTED,
  DISCONNECTING
}
