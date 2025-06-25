import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
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
            return Checkbox.adaptive(
              value: context.read<RegisterCubit>().agreePolicyAndConditions,
              activeColor: AppColors.background,
              checkColor: AppColors.kPrimary,
              fillColor: WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.background;
                }
                return AppColors.background;
              }),
              onChanged: (value) {
                context
                    .read<RegisterCubit>()
                    .agreePolicyAndConditionsFunction();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: AppColors.kPrimary),
              ),
              side: const BorderSide(
                color: AppColors.kPrimary,
                width: 1,
              ),
            );
          },
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${AppStrings.youAgreeAndHaveRead.tr} ',
                  // text: AppStrings.pleaseCheckTermsAndConditions.tr,
                  style: AppTextStyles.textMdRegular,
                ),
                TextSpan(
                  text: AppStrings.ourTermsAndPrivacyPolicy.tr,
                  style: AppTextStyles.textSmSemibold,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      CustomNavigator.push(
                        Routes.STATIC_PAGE,
                        extra: StaticPageParams(
                          url: Endpoints.privacyAndPolicy,
                          title: AppStrings.policyPrivacy.tr,
                        ),
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
