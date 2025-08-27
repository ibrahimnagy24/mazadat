import 'package:flutter/material.dart';

import '../../../../../core/shared/widgets/custom_back_icon.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/extensions/media_query_helper.dart';

class AuctionDetailsAppBar extends StatelessWidget {
  const AuctionDetailsAppBar({super.key, this.auctionStatus});
  final String? auctionStatus;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQueryHelper.width,
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Row(
          spacing: 8.w,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomBackIcon(iconColor: AppColors.kWhite),

            ///Auction Status
            if (auctionStatus != null)
              Container(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.w),
                  color: AppColors.backgroundSecondary,
                ),
                child: Text(
                  auctionStatus ?? '',
                  style: AppTextStyles.textMdRegular
                      .copyWith(color: AppColors.textPrimary),
                ),
              )
          ],
        ),
      ),
    );
  }
}
