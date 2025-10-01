import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../../core/shared/widgets/static_pages_html_bottom_sheet_widget.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/bottom_sheets/confirm_bottom_sheet.dart';
import '../../../../static_pages/data/params/static_page_params.dart';
import '../../logic/register_cubit.dart';
import '../../logic/register_state.dart';

class PrivacyAndConditionsWidget extends StatelessWidget {
  const PrivacyAndConditionsWidget({
    super.key,
    this.fontSize,
  });
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BlocBuilder<RegisterCubit, RegisterState>(
          buildWhen: (previous, current) =>
              current is AgreePolicyAndConditionsState,
          builder: (context, state) {
            return SizedBox(
              width: 20,
              height: 24,
              child: Checkbox.adaptive(
                value: context.read<RegisterCubit>().agreePolicyAndConditions,
                activeColor: AppColors.kPrimary,
                checkColor: AppColors.kWhite,
                onChanged: (value) {
                  context
                      .read<RegisterCubit>()
                      .agreePolicyAndConditionsFunction();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: const BorderSide(color: Color.fromRGBO(162, 162, 162, 1)),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            );
          },
        ),
        8.sbW,
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${AppStrings.youAgreeAndHaveRead.tr} ',
                  style: AppTextStyles.textMdRegular,
                ),
                TextSpan(
                  text: AppStrings.ourTermsAndPrivacyPolicy.tr,
                  style: AppTextStyles.textMdBold,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      CustomBottomSheet.show(
                        widget: StaticPagesHtmlBottomSheetWidget(
                          params: StaticPageParams(
                            url: Endpoints.privacyAndPolicy,
                            title: AppStrings.policyPrivacy.tr,
                          ),
                          bottomWidget: 8.sbH,
                        ),
                        dragColor: const Color.fromRGBO(46, 46, 46, 1),
                      );
                    },
                ),
                if (mainAppBloc.isArabic)
                  TextSpan(
                    text: ' حقّنا ',
                    style: AppTextStyles.textMdRegular,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
