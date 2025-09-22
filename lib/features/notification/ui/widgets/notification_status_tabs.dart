import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../cubit/notification_cubit.dart';
import '../../cubit/notification_state.dart';
import '../../data/enum/notification_type.dart';

class NotificationStatusTabs extends StatelessWidget {
  const NotificationStatusTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      buildWhen: (previous, current) => current is NotificationTypeChanged,
      builder: (context, state) {
        final cubit = context.read<NotificationCubit>();
        final currentType = cubit.getNotificationType;

        final Map<NotificationType, Widget> segmentOptions = {
          NotificationType.seller: SizedBox(
            height: 36,
            child: Center(
              child: MainText(
                text: NotificationType.seller.arabicName,
                style: currentType == NotificationType.seller
                    ? AppTextStyles.textLgBold.copyWith(color: AppColors.kWhite)
                    : AppTextStyles.textLgRegular
                        .copyWith(color: AppColors.textSecondaryParagraph),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          NotificationType.buyer: SizedBox(
            height: 36,
            child: Center(
              child: MainText(
                text: NotificationType.buyer.arabicName,
                style: currentType == NotificationType.buyer
                    ? AppTextStyles.textLgBold.copyWith(color: AppColors.kWhite)
                    : AppTextStyles.textLgRegular
                        .copyWith(color: AppColors.textSecondaryParagraph),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        };

        return SizedBox(
          height: 40,
          width: MediaQuery.sizeOf(context).width,
          child: CupertinoSlidingSegmentedControl<NotificationType>(
            children: segmentOptions,
            groupValue: currentType,
            onValueChanged: (NotificationType? value) {
              if (value != null) {
                cubit.setNotificationType(value);
              }
            },
            thumbColor: const Color.fromRGBO(138, 147, 118, 1),
            backgroundColor: AppColors.kWhite,
            padding: const EdgeInsets.all(0),
          ),
        );
      },
    );
  }
}
