import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_images.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../../../user/logic/user_cubit.dart';
import '../../logic/view_auction_details_cubit.dart';

class AuctionEndedStatusBottomSheet extends StatelessWidget {
  const AuctionEndedStatusBottomSheet({
    super.key,
    required this.modalBuildContext,
    required this.cubit,
    required this.winnerId,
  });
  final BuildContext modalBuildContext;
  final ViewAuctionDetailsCubit cubit;
  final int winnerId;
  @override
  Widget build(BuildContext context) {
    final myId = context.read<UserCubit>().userEntity?.id;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 24,
        children: [
          Image.asset(
            myId == winnerId
                ? AppImages.checkCirculerIcon
                : AppImages.wrongCircleIcon,
            height: 88,
            width: 88,
            fit: BoxFit.contain,
          ),
          Text(
            myId == winnerId
                ? AppStrings.theAuctionHasBeenAwardedToYou.tr
                : AppStrings.youWillBeRedirectedToThePaymentCompletionPage.tr,
            style: AppTextStyles.heading,
            textAlign: TextAlign.center,
          ),
          MainText(
            text: myId == winnerId
                ? AppStrings.sorryTheAwardWasNotMadeInYourFavor.tr
                : AppStrings.theAmountWillBeRefundedToThePaymentMethodUsed.tr,
          ),
          DefaultButton(
            onPressed: () {
              Navigator.pop(modalBuildContext);
              // showModalBottomSheet(
              //   context: context,
              //   isScrollControlled: true,
              //   builder: (bottomSheetContext) {
              //     return BackdropFilter(
              //       filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              //       child: BiddingOptionsBottomSheet(
              //         cubit: cubit,
              //         bottomSheetContext: bottomSheetContext,
              //       ),
              //     );
              //   },
              // );
            },
            text: AppStrings.newBidding.tr,
          ),
        ],
      ),
    );
  }
}
