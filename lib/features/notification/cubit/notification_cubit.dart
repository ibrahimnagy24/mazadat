import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../data/entity/notification_entity.dart';
import '../data/entity/notifications_response_entity.dart';
import '../data/enum/notification_type.dart';
import '../data/params/get_notification_params.dart';
import '../data/repo/notification_repo.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  NotificationType _currentNotificationType = NotificationType.seller;
  int _page = 0;
  final int _size = 50;
  NotificationsResponseEntity? _notificationsResponse;
  List<NotificationEntity> _allNotifications = [];
  bool _isLoadingMore = false;
  bool _hasMorePages = true;

  NotificationType get getNotificationType => _currentNotificationType;
  NotificationsResponseEntity? get notificationsResponse =>
      _notificationsResponse;
  List<NotificationEntity> get allNotifications => _allNotifications;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMorePages => _hasMorePages;

  bool get hasUnreadNotifications {
    if (_allNotifications.isEmpty) {
      return false;
    }
    return _allNotifications.any((notification) => !notification.isRead);
  }

  void setNotificationType(NotificationType type) {
    _currentNotificationType = type;
    emit(NotificationTypeChanged(type));
    getNotifications(isRefresh: true);
  }

  Future<void> getNotifications({bool isRefresh = false}) async {
    if (isRefresh) {
      _page = 0;
      _allNotifications.clear();
      _hasMorePages = true;
    }

    emit(GetNotificationLoading());

    final params = GetNotificationParams(
      page: _page,
      size: _size,
      notificationType:
          _currentNotificationType == NotificationType.buyer ? 'BUYER' : null,
    );

    final result = await NotificationRepo.getNotifications(params);

    result.fold(
      (error) => emit(GetNotificationError(error)),
      (data) {
        _notificationsResponse = data;

        if (isRefresh) {
          _allNotifications = data.content;
        } else {
          _allNotifications.addAll(data.content);
        }

        // Check if there are more pages
        _hasMorePages = !data.last;
        _page++;

        // Create a new response entity with all notifications for UI
        final allNotificationsResponse = NotificationsResponseEntity(
          content: _allNotifications,
          pageable: data.pageable,
          last: data.last,
          totalElements: data.totalElements,
          totalPages: data.totalPages,
          size: data.size,
          number: data.number,
          sort: data.sort,
          first: data.first,
          numberOfElements: _allNotifications.length,
          empty: _allNotifications.isEmpty,
        );

        emit(GetNotificationSuccess(allNotificationsResponse));
      },
    );
  }

  void resetPage() {
    _page = 0;
  }

  Future<void> loadMoreNotifications() async {
    // Check if already loading or no more pages
    if (_isLoadingMore || !_hasMorePages) {
      return;
    }

    _isLoadingMore = true;
    CustomNavigator.context.loaderOverlay.show();
    emit(LoadMoreNotificationLoading());

    final params = GetNotificationParams(
      page: _page,
      size: _size,
      notificationType:
          _currentNotificationType == NotificationType.buyer ? 'BUYER' : null,
    );

    final result = await NotificationRepo.getNotifications(params);

    CustomNavigator.context.loaderOverlay.hide();
    _isLoadingMore = false;

    result.fold(
      (error) => emit(LoadMoreNotificationError(error)),
      (data) {
        // Add new notifications to existing list
        _allNotifications.addAll(data.content);

        // Update pagination info
        _hasMorePages = !data.last;
        _page++;

        // Create updated response entity with all notifications
        final allNotificationsResponse = NotificationsResponseEntity(
          content: _allNotifications,
          pageable: data.pageable,
          last: data.last,
          totalElements: data.totalElements,
          totalPages: data.totalPages,
          size: data.size,
          number: data.number,
          sort: data.sort,
          first: data.first,
          numberOfElements: _allNotifications.length,
          empty: _allNotifications.isEmpty,
        );

        emit(LoadMoreNotificationSuccess(allNotificationsResponse));
      },
    );
  }

  Future<void> seenAllNotification() async {
    CustomNavigator.context.loaderOverlay.show();
    emit(SeenAllNotificationLoading());

    final result = await NotificationRepo.seenAllNotification();

    CustomNavigator.context.loaderOverlay.hide();

    result.fold(
      (error) => emit(SeenAllNotificationError(error)),
      (data) {
        emit(SeenAllNotificationSuccess(data));
        // Refresh notifications after marking all as read
        getNotifications(isRefresh: true);
      },
    );
  }

  Future<void> seenNotification(int notificationId) async {
    emit(SeenNotificationLoading());

    final result = await NotificationRepo.seenNotification(notificationId);

    result.fold(
      (error) => emit(SeenNotificationError(error)),
      (data) {
        emit(SeenNotificationSuccess(data));
        // Update the specific notification in the local list
        _updateNotificationSeenStatus(notificationId);
      },
    );
  }

  void _updateNotificationSeenStatus(int notificationId) {
    // Find and update the notification in the local list
    for (int i = 0; i < _allNotifications.length; i++) {
      if (_allNotifications[i].id == notificationId) {
        // Create a new notification with seen status updated
        final updatedNotification = NotificationEntity(
          id: _allNotifications[i].id,
          code: _allNotifications[i].code,
          action: _allNotifications[i].action,
          userId: _allNotifications[i].userId,
          flagId: _allNotifications[i].flagId,
          text: _allNotifications[i].text,
          seen: '1', // Mark as seen
          status: _allNotifications[i].status,
          creationDate: _allNotifications[i].creationDate,
          flagType: _allNotifications[i].flagType,
          type: _allNotifications[i].type,
          title: _allNotifications[i].title,
          body: _allNotifications[i].body,
          color: _allNotifications[i].color,
          creationDateString: _allNotifications[i].creationDateString,
          duration: _allNotifications[i].duration,
          unreadCount: _allNotifications[i].unreadCount,
          assetId: _allNotifications[i].assetId,
        );

        _allNotifications[i] = updatedNotification;
        break;
      }
    }

    // Create updated response entity with modified notifications
    final updatedResponse = NotificationsResponseEntity(
      content: _allNotifications,
      pageable: _notificationsResponse!.pageable,
      last: _notificationsResponse!.last,
      totalElements: _notificationsResponse!.totalElements,
      totalPages: _notificationsResponse!.totalPages,
      size: _notificationsResponse!.size,
      number: _notificationsResponse!.number,
      sort: _notificationsResponse!.sort,
      first: _notificationsResponse!.first,
      numberOfElements: _notificationsResponse!.numberOfElements,
      empty: _notificationsResponse!.empty,
    );

    // Emit updated notifications
    emit(GetNotificationSuccess(updatedResponse));
  }
}
