import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../logic/auction_manual_bidding_state.dart';

class AuctionManualBiddingButton extends StatelessWidget {
  const AuctionManualBiddingButton({
    super.key,
    required this.canBid,
    required this.id,
    required this.currentPrice,
    required this.biddingIncrementAmount,
  });
  final int id;
  final double currentPrice, biddingIncrementAmount;
  final bool canBid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuctionManualBiddingCubit(),
      child: BlocBuilder<AuctionManualBiddingCubit, AuctionManualBiddingState>(
          builder: (context, state) {
        return DefaultButton(
          onPressed: () {
            if (canBid) {
              context.read<AuctionManualBiddingCubit>().startManualBidding(id);
            }
          },
          text:
              '${AppStrings.bidWith.tr} ${(currentPrice + biddingIncrementAmount)}',
          withSaudiRiyalSymbol: true,
          isLoading: state is AuctionManualBiddingLoading,
          backgroundColor: canBid ? AppColors.kPrimary : AppColors.kDisable,
        );
      }),
    );
  }
}
