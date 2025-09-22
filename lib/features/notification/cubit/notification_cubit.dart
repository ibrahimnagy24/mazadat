import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/entity/notifications_response_entity.dart';
import '../data/enum/notification_type.dart';
import '../data/params/get_notification_params.dart';
import '../data/repo/notification_repo.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  NotificationType _currentNotificationType = NotificationType.seller;
  int _page = 0;
  int _size = 15;
  NotificationsResponseEntity? _notificationsResponse;

  NotificationType get getNotificationType => _currentNotificationType;
  NotificationsResponseEntity? get notificationsResponse => _notificationsResponse;

  void setNotificationType(NotificationType type) {
    _currentNotificationType = type;
    emit(NotificationTypeChanged(type));
  }

  Future<void> getNotifications({bool isRefresh = false}) async {
    if (isRefresh) {
      _page = 0;
    }

    emit(GetNotificationLoading());

    final params = GetNotificationParams(
      page: _page,
      size: _size,
    );

    final result = await NotificationRepo.getNotifications(params);

    result.fold(
      (error) => emit(GetNotificationError(error)),
      (data) {
        _notificationsResponse = data;
        _page++;
        emit(GetNotificationSuccess(data));
      },
    );
  }

  void resetPage() {
    _page = 0;
  }
}
