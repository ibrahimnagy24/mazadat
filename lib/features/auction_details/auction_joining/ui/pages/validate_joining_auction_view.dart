import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../../core/utils/widgets/loading/custom_loading.dart';
import '../../logic/validate_joining_auction_cubit.dart';
import '../../logic/validate_joining_auction_state.dart';
import '../widgets/validate_join_auction_button.dart';

class ValidateJoiningAuctionView extends StatelessWidget {
  const ValidateJoiningAuctionView({
    super.key,
    required this.id,
    this.onSuccess,
  });
  final int id;
  final Function()? onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ValidateJoiningAuctionCubit()..validate(id),
      child:
          BlocBuilder<ValidateJoiningAuctionCubit, ValidateJoiningAuctionState>(
        builder: (context, state) {
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 4,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: AppStrings.agreeTo.tr,
                                  style: AppTextStyles.textXLRegular.copyWith(
                                    fontSize: 16,
                                    color:
                                        const Color.fromRGBO(138, 147, 118, 1),
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '\n${AppStrings.termsAndPrivacyPolicy.tr}',
                                      style: AppTextStyles.displaySMMedium
                                          .copyWith(
                                        fontSize: 20,
                                        color:
                                            const Color.fromRGBO(81, 94, 50, 1),
                                      ),
                                    ),
                                  ]),
                            ),

                            ///Last Modified
                            Row(
                              spacing: 4,
                              children: [
                                SvgPicture.asset(
                                  AppSvg.calendar,
                                  width: 13,
                                  height: 13,
                                  color: const Color.fromRGBO(185, 185, 185, 1),
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                        text: '${AppStrings.lastModified.tr}  ',
                                        style: AppTextStyles.textMdRegular
                                            .copyWith(
                                                color: const Color.fromRGBO(
                                                    162, 162, 162, 1)),
                                        children: [
                                          TextSpan(
                                            text: (state.data.lastModified)
                                                ?.toDateFormat(
                                                    format: 'd MMMM yyyy',
                                                    locale: mainAppBloc
                                                        .lang.valueOrNull),
                                            style: AppTextStyles.textLgMedium
                                                .copyWith(
                                                    color: const Color.fromRGBO(
                                                        116, 116, 116, 1)),
                                          ),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SvgPicture.asset(
                        AppSvg.joiningAuctionBaitAlasjadyah,
                        height: 56,
                        width: 78,
                      ),
                    ],
                  ),
                ),
                const Divider(height: 32, color: AppColors.border),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: RawScrollbar(
                      thumbVisibility: true,
                      trackVisibility: true,
                      thickness: 8,
                      radius: const Radius.circular(8),
                      thumbColor: const Color.fromRGBO(209, 209, 209, 1),
                      trackColor: const Color.fromRGBO(242, 242, 242, 1),
                      trackBorderColor: Colors.transparent,
                      trackRadius: const Radius.circular(8),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8),
                        child: SingleChildScrollView(
                            child: HtmlWidget(state.data.policy ?? '')),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ValidateJoinAuctionButton(
                    id: id,
                    onSuccess: onSuccess,
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
