import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../../auction_details/view_auction/data/params/view_auction_details_route_params.dart';
import '../../cubit/notification_cubit.dart';
import '../../data/entity/notification_entity.dart';

class NotificationContainerWidget extends StatelessWidget {
  final NotificationEntity notification;

  const NotificationContainerWidget({
    super.key,
    required this.notification,
  });

  Color _parseColor(String colorString) {
    try {
      // Handle hex color format like "#FF0000"
      if (colorString.startsWith('#')) {
        return Color(
            int.parse(colorString.substring(1), radix: 16) + 0xFF000000);
      }
      // Handle RGB format like "255,0,0"
      final parts = colorString.split(',');
      if (parts.length == 3) {
        return Color.fromRGBO(
          int.parse(parts[0].trim()),
          int.parse(parts[1].trim()),
          int.parse(parts[2].trim()),
          1,
        );
      }
    } catch (e) {
      // Return default color if parsing fails
    }
    return const Color.fromRGBO(236, 247, 233, 1);
  }

  @override
  Widget build(BuildContext context) {
    // Get background color from notification or use default
    final backgroundColor = notification.color != null
        ? _parseColor(notification.color!)
        : const Color.fromRGBO(236, 247, 233, 1); // Default green

    return GestureDetector(
      onTap: () {
        // Mark notification as read if it's unread
        if (!notification.isRead) {
          context.read<NotificationCubit>().seenNotification(notification.id);
        }

        // Navigate to auction details if it's an auction notification
        if (notification.flagType == 'AUCTION') {
          CustomNavigator.push(
            Routes.VIEW_AUCTION_DETAILS,
            extra: ViewAuctionDetailsRouteParams(
              auctionId: notification.flagId,
            ),
          );
        }
      },
      child: FittedBox(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromRGBO(255, 255, 255, 0.4),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: notification.assetId != null
                        ? DefaultNetworkImage(
                            notification.assetId!,
                            width: 15,
                            height: 15,
                            fit: BoxFit.cover,
                          )
                        : SvgPicture.asset(
                            AppSvg.notification, // Default notification icon
                            height: 15,
                            width: 15,
                          ),
                  ),
                  if (!notification.isRead)
                    PositionedDirectional(
                      top: 3,
                      start: 0,
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(224, 44, 31, 1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainText(
                        text: notification.title,
                        style: AppTextStyles.textLgMedium.copyWith(
                            color: const Color.fromRGBO(81, 94, 50, 1)),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),
                      MainText(
                        text: notification.body,
                        style: AppTextStyles.textMdRegular.copyWith(
                            color: const Color.fromRGBO(162, 162, 162, 1)),
                        maxLines: 2,
                      )
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MainText(
                    text: notification.duration,
                    style: AppTextStyles.textMdRegular.copyWith(
                        color: const Color.fromRGBO(162, 162, 162, 1)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
