import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../logic/validate_joining_bundle_cubit.dart';
import '../../logic/validate_joining_bundle_state.dart';

class AgreeToInsuranceBundle extends StatelessWidget {
  const AgreeToInsuranceBundle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidateJoiningBundleCubit, ValidateJoiningBundleState>(
        builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StreamBuilder(
              stream:
                  context.read<ValidateJoiningBundleCubit>().insuranceStream,
              builder: (context, snapshot) {
                return SizedBox(
                  width: 20,
                  height: 24,
                  child: Checkbox.adaptive(
                    value: snapshot.data == true,
                    activeColor: AppColors.kPrimary,
                    checkColor: AppColors.kWhite,
                    onChanged: (value) {
                      context
                          .read<ValidateJoiningBundleCubit>()
                          .updateInsurance(value == true);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side: const BorderSide(
                      color: Color.fromRGBO(162, 162, 162, 1),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                );
              }),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: AppStrings.youAgreeToPay.tr,
                    style: AppTextStyles.textLgRegular.copyWith(
                        color: const Color.fromRGBO(162, 162, 162, 1)),
                  ),
                  TextSpan(
                    text:
                        ' ${AppStrings.insuranceAmount.tr} ${(state is ValidateJoiningBundleSuccess) ? state.data.insuranceAmount : ''} ',
                    style: AppTextStyles.textLgBold.copyWith(
                      color: const Color.fromRGBO(81, 94, 50, 1),
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  WidgetSpan(
                    child: SvgPicture.asset(
                      AppSvg.saudiArabiaSymbol,
                      width: 13,
                      height: 13,
                      color: const Color.fromRGBO(81, 94, 50, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
