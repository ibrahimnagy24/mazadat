class SeenAllNotificationResponseEntity {
  final String message;
  final String status;

  const SeenAllNotificationResponseEntity({
    required this.message,
    required this.status,
  });

  bool get isSuccess => status == '1';
}
