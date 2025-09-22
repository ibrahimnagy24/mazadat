import '../../../../core/shared/entity/error_entity.dart';
import '../data/entity/notifications_response_entity.dart';
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
