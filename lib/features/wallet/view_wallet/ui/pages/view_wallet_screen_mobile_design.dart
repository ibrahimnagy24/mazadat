import 'package:flutter/material.dart';

import '../../../../../core/assets/app_images.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/app_font_size_styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../widgets/wallet_balance_card_widget.dart';

class ViewWalletScreenMobileDesign extends StatelessWidget {
  const ViewWalletScreenMobileDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(
                text: AppStrings.myWallet.tr,
                style: AppTextStyles.displayMdBold
                    .copyWith(color: AppColors.textPrimarySaFlag),
              ),
              const SizedBox(height: 24),
              const WalletBalanceCardWidget(),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainText(
                    text: AppStrings.transactionHistory.tr,
                    style: AppTextStyles.bodyMBold,
                  ),
                  MainText(
                    text: AppStrings.viewAll.tr,
                    style: AppTextStyles.bodyMBold.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: AppFontSizes.fsXs,
                    ),
                    onTap: () {
                      CustomNavigator.push(Routes.VIEW_WALLET_HISTORY);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
