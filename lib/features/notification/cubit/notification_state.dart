import '../../../../core/shared/entity/error_entity.dart';
import '../data/entity/notifications_response_entity.dart';
import '../data/entity/seen_all_notification_response_entity.dart';
import '../data/entity/seen_notification_response_entity_new.dart';
import '../data/enum/notification_type.dart';

sealed class NotificationState {
  const NotificationState();
}

final class NotificationInitial extends NotificationState {}

final class NotificationTypeChanged extends NotificationState {
  final NotificationType type;

  const NotificationTypeChanged(this.type);
}

final class GetNotificationLoading extends NotificationState {}

final class GetNotificationSuccess extends NotificationState {
  final NotificationsResponseEntity entity;

  const GetNotificationSuccess(this.entity);
}

final class GetNotificationError extends NotificationState {
  final ErrorEntity errorEntity;

  const GetNotificationError(this.errorEntity);
}

final class SeenAllNotificationLoading extends NotificationState {}

final class SeenAllNotificationSuccess extends NotificationState {
  final SeenAllNotificationResponseEntity entity;

  const SeenAllNotificationSuccess(this.entity);
}

final class SeenAllNotificationError extends NotificationState {
  final ErrorEntity errorEntity;

  const SeenAllNotificationError(this.errorEntity);
}

final class LoadMoreNotificationLoading extends NotificationState {}

final class LoadMoreNotificationSuccess extends NotificationState {
  final NotificationsResponseEntity entity;

  const LoadMoreNotificationSuccess(this.entity);
}

final class LoadMoreNotificationError extends NotificationState {
  final ErrorEntity errorEntity;

  const LoadMoreNotificationError(this.errorEntity);
}

final class SeenNotificationLoading extends NotificationState {}

final class SeenNotificationSuccess extends NotificationState {
  final SeenNotificationResponseEntity entity;

  const SeenNotificationSuccess(this.entity);
}

final class SeenNotificationError extends NotificationState {
  final ErrorEntity errorEntity;

  const SeenNotificationError(this.errorEntity);
}
