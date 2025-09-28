import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../cubit/notification_cubit.dart';
import '../../data/entity/notification_entity.dart';
import '../../utils/notification_date_helper.dart';
import 'notification_container_widget.dart';

class GroupedNotificationsList extends StatefulWidget {
  final List<NotificationEntity> notifications;
  const GroupedNotificationsList({
    super.key,
    required this.notifications,
  });

  @override
  State<GroupedNotificationsList> createState() =>
      _GroupedNotificationsListState();
}

class _GroupedNotificationsListState extends State<GroupedNotificationsList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      // User has scrolled to 80% of the content
      context.read<NotificationCubit>().loadMoreNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupedNotifications =
        NotificationDateHelper.groupNotificationsByDate(widget.notifications);
    final sortedKeys =
        NotificationDateHelper.getSortedDateKeys(groupedNotifications);

    return ListView.builder(
      controller: _scrollController,
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
                  child:
                      NotificationContainerWidget(notification: notification),
                )),
          ],
        );
      },
    );
  }
}
