class GetNotificationParams {
  final int page;
  final int size;
  final String? notificationType;

  const GetNotificationParams({
    required this.page,
    required this.size,
    required this.notificationType,
  });

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'page': page,
      'size': size,
      'type': notificationType,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
