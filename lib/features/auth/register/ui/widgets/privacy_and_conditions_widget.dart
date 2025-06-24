import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_config/api_names.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
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
    final cubit = context.read<RegisterCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BlocBuilder<RegisterCubit, RegisterState>(
          buildWhen: (previous, current) =>
              current is AgreePolicyAndConditionsState,
          builder: (context, state) {
            return Checkbox.adaptive(
              value: cubit.agreePolicyAndConditions,
              activeColor: AppColors.kPrimary700,
              checkColor: AppColors.kWhite,
              fillColor: WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.kPrimary700;
                }
                return Colors.white;
              }),
              onChanged: (value) {
                cubit.agreePolicyAndConditionsFunction();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: AppColors.kOpacityGrey),
              ),
              side: const BorderSide(
                color: AppColors.kOpacityGrey,
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
                  text: mainAppBloc.isArabic
                      ? 'أنت موافق وقريت'
                      : 'You agree and have read',
                  // text: AppStrings.pleaseCheckTermsAndConditions.tr,
                  style: AppTextStyles.bodyXsReq.copyWith(
                    fontSize: fontSize ?? 14,
                    color: AppColors.kGeryText6,
                  ),
                ),
                const TextSpan(text: ' '),
                TextSpan(
                  text: mainAppBloc.isArabic
                      ? 'شروطنا وسياسة الخصوصية'
                      : 'our Terms and Privacy Policy',
                  // text: AppStrings.termsAndConditions.tr,
                  style: AppTextStyles.bodyXsMed.copyWith(
                    fontSize: fontSize ?? 14,
                    color: AppColors.kPrimary500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      CustomNavigator.push(
                        Routes.STATIC_PAGE,
                        extra: const StaticPageParams(
                          url: Endpoints.privacyAndPolicy,
                          title: 'AppStrings.policyPrivacy',
                        ),
                      );
                    },
                ),
                if (mainAppBloc.isArabic)
                  TextSpan(
                    text: ' حقّنا ',
                    // text: AppStrings.pleaseCheckTermsAndConditions.tr,
                    style: AppTextStyles.bodyXsReq.copyWith(
                      fontSize: fontSize ?? 14,
                      color: AppColors.kGeryText6,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
