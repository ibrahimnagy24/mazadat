class NotificationEntity {
  final int id;
  final String code;
  final String? action;
  final int userId;
  final int flagId;
  final String? text;
  final String seen;
  final String status;
  final String creationDate;
  final String flagType;
  final String type;
  final String title;
  final String body;
  final String? color;
  final String creationDateString;
  final String duration;
  final int unreadCount;
  final String? assetId;

  const NotificationEntity({
    required this.id,
    required this.code,
    this.action,
    required this.userId,
    required this.flagId,
    this.text,
    required this.seen,
    required this.status,
    required this.creationDate,
    required this.flagType,
    required this.type,
    required this.title,
    required this.body,
    this.color,
    required this.creationDateString,
    required this.duration,
    required this.unreadCount,
    this.assetId,
  });

  bool get isRead => seen == '1';
  
  DateTime get createdAt {
    try {
      return DateTime.parse(creationDate);
    } catch (e) {
      return DateTime.now();
    }
  }
}
