import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../logic/auction_switch_bidding_state.dart';

class AuctionSwitchBiddingButton extends StatelessWidget {
  const AuctionSwitchBiddingButton({super.key, required this.id, this.onSuccess});
  final int id;
  final Function()? onSuccess;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: DefaultButton(
        text: AppStrings.confirm.tr,
        onPressed: ()=>
          context.read<AuctionSwitchBiddingCubit>().switchBidding(id:id,onSuccess: onSuccess),
      ),
    );
  }
}
