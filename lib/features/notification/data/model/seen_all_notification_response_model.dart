import '../entity/seen_all_notification_response_entity.dart';

class SeenAllNotificationResponseModel extends SeenAllNotificationResponseEntity {
  const SeenAllNotificationResponseModel({
    required super.message,
    required super.status,
  });

  factory SeenAllNotificationResponseModel.fromJson(Map<String, dynamic> json) {
    return SeenAllNotificationResponseModel(
      message: json['message'] ?? '',
      status: json['status'] ?? '0',
    );
  }
}
