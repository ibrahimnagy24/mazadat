class SeenNotificationResponseModel {
  final String message;
  final String status;

  const SeenNotificationResponseModel({
    required this.message,
    required this.status,
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
