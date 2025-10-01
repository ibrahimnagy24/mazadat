import '../entity/seen_notification_response_entity_new.dart';

class SeenNotificationResponseModel extends SeenNotificationResponseEntity {
  const SeenNotificationResponseModel({
    required super.message,
    required super.status,
  });

  factory SeenNotificationResponseModel.fromJson(Map<String, dynamic> json) {
    return SeenNotificationResponseModel(
      message: json['message'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
    };
  }
}
