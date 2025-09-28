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
import '../../data/params/validate_bundle_params.dart';
import '../../logic/validate_joining_bundle_cubit.dart';
import '../../logic/validate_joining_bundle_state.dart';
import '../widgets/validate_join_bundle_button.dart';

class ValidateJoiningBundleView extends StatelessWidget {
  const ValidateJoiningBundleView({
    super.key,
    required this.params,
    this.onSuccess,
    required this.bottomSheetContext,
  });
  final ValidateBundleParams params;
  final Function()? onSuccess;
  final BuildContext bottomSheetContext;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ValidateJoiningBundleCubit()..validate(params),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child:
            BlocBuilder<ValidateJoiningBundleCubit, ValidateJoiningBundleState>(
                builder: (context, state) {
          if (state is ValidateJoiningBundleLoading) {
            return const CustomLoading();
          }
          if (state is ValidateJoiningBundleError) {
            return ErrorMessageWidget(
              error: state.error,
              onTap: () {
                context.read<ValidateJoiningBundleCubit>().validate(params);
              },
            );
          }
          if (state is ValidateJoiningBundleSuccess) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  Row(
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
                                  width: 16,
                                  height: 16,
                                  color: const Color.fromRGBO(185, 185, 185, 1),
                                ),
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
                      SvgPicture.asset(
                        AppSvg.logo,
                        height: 56,
                        width: 78,
                        color: const Color.fromRGBO(81, 94, 50, 1),
                      ),
                    ],
                  ),
                  const Divider(height: 32, color: AppColors.border),
                  Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      trackVisibility: true,
                      child: SingleChildScrollView(
                        child: HtmlWidget(state.data.policy ?? ''),
                      ),
                    ),
                  ),
                  SafeArea(
                    top: false,
                    left: false,
                    right: false,
                    child: ValidateJoinBundleButton(
                      id: params.id,
                      onSuccess: onSuccess,
                      bottomSheetContext: bottomSheetContext,
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }
}
