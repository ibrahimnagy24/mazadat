import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/assets/app_images.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/services/toast_service.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/utility.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../../visitor/ui/pages/visitor_screen.dart';
import '../../cubit/notification_cubit.dart';
import '../../cubit/notification_state.dart';
import '../widgets/grouped_notifications_list.dart';
import '../widgets/notification_status_tabs.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return !Utility.isUserLoggedIn()
        ? const CustomScaffoldWidget(child: VisitorScreen())
        : BlocProvider(
            create: (context) =>
                NotificationCubit()..getNotifications(isRefresh: true),
            child: CustomScaffoldWidget(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => CustomNavigator.pop(),
                          child: RotatedBox(
                            quarterTurns:
                                mainAppBloc.lang.valueOrNull == 'en' ? 2 : 0,
                            child: SvgPicture.asset(
                              AppSvg.arrowBack,
                              width: 30,
                              height: 24,
                              color: const Color.fromRGBO(22, 22, 22, 1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MainText(
                              text: AppStrings.notifications.tr,
                              style: AppTextStyles.displayMdBold.copyWith(
                                color: const Color.fromRGBO(34, 39, 21, 1),
                                fontSize: 24,
                              ),
                            ),
                            BlocConsumer<NotificationCubit, NotificationState>(
                              listener: (context, state) {
                                if (state is SeenAllNotificationSuccess) {
                                  ToastService.showCustom(
                                    message: state.entity.message,
                                    context: context,
                                    toastStatusType: ToastStatusType.success,
                                  );
                                  context
                                      .read<NotificationCubit>()
                                      .getNotifications(isRefresh: true);
                                }
                                if (state is SeenAllNotificationError) {
                                  ToastService.showCustom(
                                    message: state.errorEntity.message,
                                    context: context,
                                    toastStatusType: ToastStatusType.error,
                                    errorEntity: state.errorEntity,
                                  );
                                }
                                if (state is SeenNotificationSuccess) {
                                  // ToastService.showCustom(
                                  //   message: state.entity.message,
                                  //   context: context,
                                  //   toastStatusType: ToastStatusType.success,
                                  // );
                                }
                                if (state is SeenNotificationError) {
                                  ToastService.showCustom(
                                    message: state.errorEntity.message,
                                    context: context,
                                    toastStatusType: ToastStatusType.error,
                                    errorEntity: state.errorEntity,
                                  );
                                }
                              },
                              buildWhen: (previous, current) =>
                                  current is GetNotificationSuccess ||
                                  current is GetNotificationLoading ||
                                  current is GetNotificationError,
                              builder: (context, state) {
                                final cubit = context.read<NotificationCubit>();

                                // Only show "Mark All as Read" if there are unread notifications
                                if (!cubit.hasUnreadNotifications) {
                                  return const SizedBox.shrink();
                                }

                                return GestureDetector(
                                  onTap: () {
                                    cubit.seenAllNotification();
                                  },
                                  child: MainText(
                                    text: AppStrings.markAllAsRead.tr,
                                    style:
                                        AppTextStyles.textMdSemibold.copyWith(
                                      color:
                                          const Color.fromRGBO(81, 94, 50, 1),
                                      fontSize: 12,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const NotificationStatusTabs(),
                    const SizedBox(height: 24),
                    Expanded(
                      child: BlocBuilder<NotificationCubit, NotificationState>(
                        buildWhen: (previous, current) =>
                            current is GetNotificationLoading ||
                            current is GetNotificationSuccess ||
                            current is GetNotificationError ||
                            current is LoadMoreNotificationSuccess ||
                            current is LoadMoreNotificationError,
                        builder: (context, state) {
                          if (state is GetNotificationLoading) {
                            return const SizedBox(
                              height: 300,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          if (state is GetNotificationSuccess ||
                              state is LoadMoreNotificationSuccess) {
                            final notifications =
                                state is GetNotificationSuccess
                                    ? state.entity.content
                                    : (state as LoadMoreNotificationSuccess)
                                        .entity
                                        .content;
                            if (notifications.isEmpty) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 120),
                                  Image.asset(
                                    AppImages.notificationBill,
                                    height: 270,
                                    width: 270,
                                  ),
                                  const SizedBox(height: 24),
                                  MainText(
                                    text: AppStrings.youHaveNoNotifications.tr,
                                    style: AppTextStyles.displayMdSemiBold
                                        .copyWith(
                                            color: const Color.fromRGBO(
                                                81, 94, 50, 1)),
                                  ),
                                ],
                              );
                            }
                            return GroupedNotificationsList(
                                notifications: notifications);
                          }
                          if (state is GetNotificationError) {
                            return SizedBox(
                              height: 300,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.error_outline,
                                      size: 64,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(height: 16),
                                    MainText(
                                      text: state.errorEntity.message,
                                      style:
                                          AppTextStyles.textMdRegular.copyWith(
                                        color: Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<NotificationCubit>()
                                            .getNotifications(isRefresh: true);
                                      },
                                      child: MainText(
                                        text: 'إعادة المحاولة',
                                        style: AppTextStyles.textMdMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
