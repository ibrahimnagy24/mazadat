import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../logic/view_auction_details_cubit.dart';
import 'bidding_options_bottom_sheet.dart';

class ViewAuctionExceedMaxBiddingAlert extends StatelessWidget {
  const ViewAuctionExceedMaxBiddingAlert({
    super.key,
    required this.modalBuildContext,
    required this.cubit,
  });
  final BuildContext modalBuildContext;
  final ViewAuctionDetailsCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 24,
        children: [
          SvgPicture.asset(
            AppSvg.alert,
            width: 90,
            height: 90,
          ),
          Text(
            AppStrings.theSpecifiedBidValueHasBeeReached.tr,
            style: AppTextStyles.heading,
            textAlign: TextAlign.center,
          ),
          SafeArea(
            top: false,
            left: false,
            right: false,
            child: DefaultButton(
              onPressed: () {
                Navigator.pop(modalBuildContext);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (bottomSheetContext) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: BiddingOptionsBottomSheet(
                        cubit: cubit,
                        bottomSheetContext: bottomSheetContext,
                      ),
                    );
                  },
                );
              },
              text: AppStrings.newBidding.tr,
            ),
          ),
        ],
      ),
    );
  }
}
