import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../data/entity/notification_entity.dart';
import '../../utils/notification_date_helper.dart';
import 'notification_container_widget.dart';

class GroupedNotificationsList extends StatelessWidget {
  final List<NotificationEntity> notifications;

  const GroupedNotificationsList({
    super.key,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    final groupedNotifications = NotificationDateHelper.groupNotificationsByDate(notifications);
    final sortedKeys = NotificationDateHelper.getSortedDateKeys(groupedNotifications);

    return Expanded(
      child: ListView.builder(
        itemCount: sortedKeys.length,
        itemBuilder: (context, index) {
          final dateKey = sortedKeys[index];
          final dayNotifications = groupedNotifications[dateKey]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date header
              Padding(
                padding: EdgeInsets.only(bottom: 16, top: index == 0 ? 0 : 24),
                child: MainText(
                  text: dateKey,
                  style: AppTextStyles.textLgBold.copyWith(
                    color: const Color.fromRGBO(81, 94, 50, 1),
                  ),
                ),
              ),
              // Notifications for this date
              ...dayNotifications.map((notification) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: NotificationContainerWidget(
                  notification: notification,
                ),
              )),
            ],
          );
        },
      ),
    );
  }
}
