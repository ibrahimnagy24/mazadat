import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_core.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/bottom_sheets/confirm_bottom_sheet.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../logic/validate_joining_auction_state.dart';
import '../pages/join_auction_view.dart';
import 'agree_to_commission.dart';
import 'agree_to_insurance.dart';

class ValidateJoinAuctionButton extends StatelessWidget {
  const ValidateJoinAuctionButton({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        children: [
          const AgreeToCommission(),
          const AgreeToInsurance(),
          8.sbH,
          DefaultButton(
            text: AppStrings.confirm.tr,
            onPressed: () {
              if (context
                      .read<ValidateJoiningAuctionCubit>()
                      .commission
                      .valueOrNull !=
                  true) {
                showToast(AppStrings.agreeToCommissionAndInsurance.tr);
              } else if (context
                      .read<ValidateJoiningAuctionCubit>()
                      .insurance
                      .valueOrNull !=
                  true) {
                showToast(AppStrings.agreeToCommissionAndInsurance.tr);
              } else {
                CustomBottomSheet.show(
                    label: AppStrings.selectPaymentMethod.tr,
                    widget: JoinAuctionView(id: id));
              }
            },
          ),
        ],
      ),
    );
  }
}
