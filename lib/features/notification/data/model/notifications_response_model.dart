import '../entity/notifications_response_entity.dart';
import 'notification_model.dart';
import 'pageable_model.dart';

class NotificationsResponseModel extends NotificationsResponseEntity {
  const NotificationsResponseModel({
    required super.content,
    required super.pageable,
    required super.last,
    required super.totalElements,
    required super.totalPages,
    required super.size,
    required super.number,
    required super.sort,
    required super.first,
    required super.numberOfElements,
    required super.empty,
  });

  factory NotificationsResponseModel.fromJson(Map<String, dynamic> json) {
    final contentList = json['content'] as List? ?? [];
    final notifications = contentList
        .map((item) => NotificationModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return NotificationsResponseModel(
      content: notifications,
      pageable: PageableModel.fromJson(json['pageable'] ?? {}),
      last: json['last'] ?? true,
      totalElements: json['totalElements'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      size: json['size'] ?? 0,
      number: json['number'] ?? 0,
      sort: SortModel.fromJson(json['sort'] ?? {}),
      first: json['first'] ?? true,
      numberOfElements: json['numberOfElements'] ?? 0,
      empty: json['empty'] ?? true,
    );
  }
}
