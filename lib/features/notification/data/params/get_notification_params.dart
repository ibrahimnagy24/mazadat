class GetNotificationParams {
  final int page;
  final int size;

  const GetNotificationParams({
    required this.page,
    required this.size,
  });

  Map<String, dynamic> returnedMap() {
    return {
      'page': page,
      'size': size,
    };
  }
}
