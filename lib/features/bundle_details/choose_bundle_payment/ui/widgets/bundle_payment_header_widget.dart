import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';

class BundlePaymentHeaderWidget extends StatelessWidget {
  const BundlePaymentHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => CustomNavigator.pop(),
          child: RotatedBox(
            quarterTurns: mainAppBloc.lang.valueOrNull == 'en' ? 2 : 0,
            child: SvgPicture.asset(
              AppSvg.arrowBack,
              width: 30,
              height: 24,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 16),
        MainText(
          text: AppStrings.selectPaymentMethod.tr,
          style: AppTextStyles.textMdBold.copyWith(
            color: const Color.fromRGBO(34, 39, 21, 1),
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
