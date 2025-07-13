import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/loading/custom_loading.dart';
import '../../logic/validate_joining_auction_state.dart';
import '../widgets/validate_join_auction_button.dart';

class ValidateJoiningAuctionView extends StatelessWidget {
  const ValidateJoiningAuctionView({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ValidateJoiningAuctionCubit()..validate(id),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: BlocBuilder<ValidateJoiningAuctionCubit,
              ValidateJoiningAuctionState>(builder: (context, state) {
            if (state is ValidateJoiningAuctionLoading) {
              return const CustomLoading();
            }
            if (state is ValidateJoiningAuctionError) {
              return ErrorMessageWidget(
                error: state.error,
                onTap: () {
                  context.read<ValidateJoiningAuctionCubit>().validate(id);
                },
              );
            }
            if (state is ValidateJoiningAuctionSuccess) {
              return Column(
                children: [
                  Row(
                    spacing: 8.w,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 4.h,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: AppStrings.agreeTo.tr,
                                  style: AppTextStyles.textXLRegular
                                      .copyWith(fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text:
                                          '\n${AppStrings.termsAndPrivacyPolicy.tr}',
                                      style: AppTextStyles.displaySMMedium
                                          .copyWith(fontSize: 20),
                                    ),
                                  ]),
                            ),

                            ///Last Modified
                            Row(
                              spacing: 8.w,
                              children: [
                                customImageIconSVG(
                                    imageName: AppSvg.calendar,
                                    width: 16.w,
                                    height: 16.w,
                                    color: AppColors.iconDefault),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                        text: '${AppStrings.lastModified.tr}  ',
                                        style: AppTextStyles.textLgRegular,
                                        children: [
                                          TextSpan(
                                            text: (state.data.lastModified)
                                                ?.toDateFormat(
                                                    format: 'd MMMM yyyy',
                                                    locale: mainAppBloc
                                                        .lang.valueOrNull),
                                            style: AppTextStyles.textLgRegular
                                                .copyWith(
                                                    color:
                                                        AppColors.textPrimary),
                                          ),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      customImageIconSVG(
                          imageName: AppSvg.logo,
                          height: 75.h,
                          width: 105.w,
                          color: AppColors.kPrimary),
                    ],
                  ),
                  Divider(height: 32.h, color: AppColors.border),
                  Expanded(
                    child: Scrollbar(
                      child: HtmlWidget(state.data.policy ?? ''),
                    ),
                  ),
                  ValidateJoinAuctionButton(id: id),
                ],
              );
            }
            return const SizedBox();
          }),
        ));
  }
}
