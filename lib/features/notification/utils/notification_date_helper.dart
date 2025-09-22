import '../../../core/shared/blocs/main_app_bloc.dart';
import '../data/entity/notification_entity.dart';

class NotificationDateHelper {
  static Map<String, List<NotificationEntity>> groupNotificationsByDate(
      List<NotificationEntity> notifications) {
    final Map<String, List<NotificationEntity>> groupedNotifications = {};
    final now = DateTime.now();
    final isArabic = mainAppBloc.lang.valueOrNull == 'ar';

    for (final notification in notifications) {
      final dateKey = _getDateGroupKey(notification.createdAt, now, isArabic);
      if (groupedNotifications.containsKey(dateKey)) {
        groupedNotifications[dateKey]!.add(notification);
      } else {
        groupedNotifications[dateKey] = [notification];
      }
    }

    // Sort each group by time (newest first)
    groupedNotifications.forEach((key, value) {
      value.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });

    return groupedNotifications;
  }

  static String _getDateGroupKey(DateTime date, DateTime now, bool isArabic) {
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return isArabic ? 'اليوم' : 'Today';
    } else if (difference == 1) {
      return isArabic ? 'أمس' : 'Yesterday';
    } else if (difference == 2) {
      return isArabic ? 'منذ يومين' : '2 days ago';
    } else if (difference < 7) {
      return isArabic ? 'منذ $difference أيام' : '$difference days ago';
    } else if (difference < 30) {
      final weeks = (difference / 7).floor();
      if (weeks == 1) {
        return isArabic ? 'منذ أسبوع' : '1 week ago';
      } else {
        return isArabic ? 'منذ $weeks أسابيع' : '$weeks weeks ago';
      }
    } else {
      final months = (difference / 30).floor();
      if (months == 1) {
        return isArabic ? 'منذ شهر' : '1 month ago';
      } else {
        return isArabic ? 'منذ $months أشهر' : '$months months ago';
      }
    }
  }

  static List<String> getSortedDateKeys(Map<String, List<NotificationEntity>> groupedNotifications) {
    final isArabic = mainAppBloc.lang.valueOrNull == 'ar';
    final keys = groupedNotifications.keys.toList();
    
    // Define the order of date keys
    final order = isArabic 
        ? ['اليوم', 'أمس', 'منذ يومين']
        : ['Today', 'Yesterday', '2 days ago'];
    
    keys.sort((a, b) {
      final aIndex = order.indexOf(a);
      final bIndex = order.indexOf(b);
      
      if (aIndex != -1 && bIndex != -1) {
        return aIndex.compareTo(bIndex);
      } else if (aIndex != -1) {
        return -1;
      } else if (bIndex != -1) {
        return 1;
      } else {
        // For other dates, sort by the actual date (newest first)
        return a.compareTo(b);
      }
    });
    
    return keys;
  }
}
