import '../../../../core/assets/app_svg.dart';

enum NotificationStatus {
  delivered,
  shipping,
  reminder,
  cancelled;

  String get arabicTitle {
    switch (this) {
      case NotificationStatus.delivered:
        return 'تم التوصيل';
      case NotificationStatus.shipping:
        return 'جاري الشحن';
      case NotificationStatus.reminder:
        return 'تذكير';
      case NotificationStatus.cancelled:
        return 'تم الإلغاء';
    }
  }

  String get englishTitle {
    switch (this) {
      case NotificationStatus.delivered:
        return 'Delivered';
      case NotificationStatus.shipping:
        return 'Shipping';
      case NotificationStatus.reminder:
        return 'Reminder';
      case NotificationStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get iconPath {
    switch (this) {
      case NotificationStatus.delivered:
        return AppSvg.check;
      case NotificationStatus.shipping:
        return AppSvg.van;
      case NotificationStatus.reminder:
        return AppSvg.alarmClock;
      case NotificationStatus.cancelled:
        return AppSvg.cancelXmark;
    }
  }

  String get backgroundColor {
    switch (this) {
      case NotificationStatus.delivered:
        return '236, 247, 233'; // Green
      case NotificationStatus.shipping:
        return '255, 246, 230'; // Orange
      case NotificationStatus.reminder:
        return '238, 239, 235'; // Gray
      case NotificationStatus.cancelled:
        return '252, 234, 233'; // Red
    }
  }
}