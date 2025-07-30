import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_images.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../logic/view_my_wallet_cubit.dart';
import 'recharge_wallet_bottom_sheet_widget.dart';

class WalletBalanceCardWidget extends StatelessWidget {
  const WalletBalanceCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 148,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.walletBackground),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 12,
              bottom: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.transparent,
                      builder: (dialogContext) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: RechargeWalletBottomSheetWidget(
                            dialogContext: dialogContext,
                            cubit: context.read<ViewMyWalletCubit>(),
                          ),
                        );
                      },
                    );
                  },
                  child: Image.asset(
                    AppImages.addFloatingIcon,
                    height: 48,
                    width: 48,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      AppImages.arrowReloadHorizontal,
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(width: 4),
                    MainText(
                      text: 'تاريخ التحديث 15 مايو 2025',
                      style: AppTextStyles.textMdRegular
                          .copyWith(color: AppColors.kWhite),
                    )
                  ],
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(
                text: AppStrings.currentBalance.tr,
                style: AppTextStyles.textXLMedium
                    .copyWith(color: AppColors.mainDark),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MainText(
                    text: '400,000,000',
                    style: AppTextStyles.displaySMBold,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    AppImages.saudiRiyalSymbol,
                    height: 21,
                    width: 21,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
