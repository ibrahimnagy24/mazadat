import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/assets/app_images.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';

class RechargeWalletStatusWidget extends StatelessWidget {
  const RechargeWalletStatusWidget({
    super.key,
    required this.dialogContext,
    required this.isTransactionSuccess,
  });
  final BuildContext dialogContext;
  final bool isTransactionSuccess;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    isTransactionSuccess
                        ? AppImages.checkCirculerIcon
                        : AppImages.wrongCircleIcon,
                    height: 88,
                    width: 88,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    icon: const Icon(
                      CupertinoIcons.xmark,
                      color: AppColors.iconDefault,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          MainText(
            text: isTransactionSuccess
                ? AppStrings.theWalletHasBeenSuccessfullyCharged.tr
                : AppStrings.aProblemOccurred.tr,
            style: AppTextStyles.displaySMMedium,
          ),
          const SizedBox(height: 8),
          MainText(
            text: isTransactionSuccess
                ? 'رقم المعاملة :1234543'
                : AppStrings.pleaseTryAgainLater.tr,
            style: AppTextStyles.textLgRegular,
          ),
          const SizedBox(height: 24),
          DefaultButton(
            backgroundColor: AppColors.buttonBackgroundPrimaryDefault,
            text: AppStrings.good.tr,
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            textStyle:
                AppTextStyles.textXLBold.copyWith(color: AppColors.kWhite),
          )
        ],
      ),
    );
  }
}
