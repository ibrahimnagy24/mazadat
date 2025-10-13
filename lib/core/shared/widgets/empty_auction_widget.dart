import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../assets/app_images.dart';
import '../../theme/colors/styles.dart';
import '../../theme/text_styles/text_styles.dart';
import '../../utils/extensions/extensions.dart';
import '../../utils/widgets/text/main_text.dart';

class EmptyAuctionWidget extends StatelessWidget {
  const EmptyAuctionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(32),
      margin: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.kPrimary.withOpacity(0.1),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.baitElasjadiahVisitorLogo,
            height: 165,
          )
              .animate()
              .fadeIn(
                duration: 800.ms,
                curve: Curves.easeOutCubic,
              )
              .slideY(
                begin: -0.1,
                duration: 800.ms,
                curve: Curves.easeOutCubic,
              ),
          32.sbH,
          MainText(
            text: 'No Auctions'.tr,
            style: AppTextStyles.textMdSemiboldIbmPlexSansArabic,
            textAlign: TextAlign.center,
          )
              .animate(delay: 200.ms)
              .fadeIn(
                duration: 600.ms,
                curve: Curves.easeOut,
              )
              .slideY(
                begin: 0.2,
                duration: 600.ms,
                curve: Curves.easeOut,
              ),
          16.sbH,
          MainText(
            text:
                'There are no categories available at the moment, expect special auctions soon.'
                    .tr,
            style: AppTextStyles.textLgMedium,
            textAlign: TextAlign.center,
          )
              .animate(delay: 400.ms)
              .fadeIn(
                duration: 600.ms,
                curve: Curves.easeOut,
              )
              .slideY(
                begin: 0.2,
                duration: 600.ms,
                curve: Curves.easeOut,
              ),
        ],
      ),
    );
  }
}
