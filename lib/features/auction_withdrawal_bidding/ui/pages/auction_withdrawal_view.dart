import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../logic/auction_withdrawal_state.dart';


class AuctionWithdrawalView extends StatelessWidget {
  const AuctionWithdrawalView({super.key, required this.id,this.onSuccess});
  final int id;
  final Function()? onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuctionWithdrawalCubit(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: BlocBuilder<AuctionWithdrawalCubit, AuctionWithdrawalState>(
              builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                customImageIconSVG(
                  imageName: AppSvg.withdrawal,
                  width: 90.w,
                  height: 90.w,
                ),
                24.sbH,
                Text(
                  AppStrings.areYouSureYouWantToWithdrawFromTheAuction.tr,
                  style: AppTextStyles.heading,
                  textAlign: TextAlign.center,
                ),
                8.sbH,
                Text(
                  AppStrings.theAmountWillBeRefundedToThePaymentMethodUsed.tr,
                  style: AppTextStyles.textLgRegular,
                  textAlign: TextAlign.center,
                ),
                24.sbH,
                DefaultButton(
                  backgroundColor: AppColors.kWhite,
                  borderColor: AppColors.RED,
                  textColor: AppColors.RED,
                  text: AppStrings.withdrawal.tr,
                  onPressed: ()=>
                      context.read<AuctionWithdrawalCubit>().withdraw(id:id,onSuccess: onSuccess),
                ),
              ],
            );
          }),
        ));
  }
}
