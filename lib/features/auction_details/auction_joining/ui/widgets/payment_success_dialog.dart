import 'package:flutter/material.dart';
import '../../../../../../core/assets/app_svg.dart';
import '../../../../../../core/shared/widgets/custom_images.dart';
import '../../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../../core/utils/constant/app_strings.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../../core/theme/colors/styles.dart';

class PaymentSuccessDialog extends StatelessWidget {
  const PaymentSuccessDialog(
      {super.key, required this.isSuccess, this.error, this.onTap});
  final bool isSuccess;
  final String? error;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24.h,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        isSuccess
            ? customImageIconSVG(
                imageName: AppSvg.success,
                width: 90.w,
                height: 90.w,
              )
            : customContainerSvgIcon(
                imageName: AppSvg.cancel,
                width: 90.w,
                height: 90.w,
                padding: 12.w,
                radius: 100.w,
                color: AppColors.kWhite,
                backGround: AppColors.RED),
        Text(
          isSuccess
              ? AppStrings.youHaveSuccessfullySubscribedToTheAuction.tr
              : error ?? AppStrings.somethingWentWrong,
          style: AppTextStyles.heading,
          textAlign: TextAlign.center,
        ),
        DefaultButton(
          text: isSuccess ? AppStrings.Continue.tr : AppStrings.tryAgain.tr,
          onPressed: () {
            onTap?.call();
          },
        )
      ],
    );
  }
}
