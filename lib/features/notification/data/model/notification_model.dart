import '../entity/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.code,
    super.action,
    required super.userId,
    required super.flagId,
    super.text,
    required super.seen,
    required super.status,
    required super.creationDate,
    required super.flagType,
    required super.type,
    required super.title,
    required super.body,
    super.color,
    required super.creationDateString,
    required super.duration,
    required super.unreadCount,
    super.assetId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      action: json['action'],
      userId: json['userId'] ?? 0,
      flagId: json['flagId'] ?? 0,
      text: json['text'],
      seen: json['seen'] ?? '0',
      status: json['status'] ?? '',
      creationDate: json['creationDate'] ?? '',
      flagType: json['flagType'] ?? '',
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      color: json['color'],
      creationDateString: json['creationDateString'] ?? '',
      duration: json['duration'] ?? '',
      unreadCount: json['unreadCount'] ?? 0,
      assetId: json['assetId'],
    );
  }
}
