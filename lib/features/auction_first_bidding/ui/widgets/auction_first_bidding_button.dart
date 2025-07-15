import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../../logic/auction_first_bidding_state.dart';

class AuctionFirstBiddingButton extends StatelessWidget {
  const AuctionFirstBiddingButton({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: DefaultButton(
        text: AppStrings.bid.tr,
        onPressed: ()=>
          context.read<AuctionFirstBiddingCubit>().firstBidding(id),
      ),
    );
  }
}
