import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../data/entity/auction_entity.dart';

class AuctionCardWidget extends StatelessWidget {
  const AuctionCardWidget({
    super.key,
    this.onTap,
    this.height = 207,
    required this.auction,
  });

  final void Function()? onTap;
  final double height;
  final AuctionEntity auction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.rXS),
          color: AppColors.fillColor,
          border: Border.all(color: AppColors.kGeryText8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                // Display auction image if available
                auction.images.isNotEmpty
                    ? DefaultNetworkImage(
                        auction.images.first.path,
                        radius: AppRadius.rXXS,
                        height: 135,
                      )
                    : Container(
                        height: 135,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppRadius.rXXS),
                          color: AppColors.kGeryText8,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.gavel_outlined,
                            size: 48,
                            color: AppColors.textSecondaryParagraph,
                          ),
                        ),
                      ),
                if (auction.status.isNotEmpty)
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 12,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(AppRadius.rXXS),
                          bottomEnd: Radius.circular(AppRadius.rXXS),
                        ),
                        color: AppColors.kPrimary,
                      ),
                      child: Text(
                        auction.status,
                        style: AppTextStyles.textMdRegular
                            .copyWith(color: AppColors.textPrimary),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (auction.openingPrice.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainText(
                    text: AppStrings.openingPrice.tr,
                    style: AppTextStyles.bodyXXsReq
                        .copyWith(color: AppColors.textSecondaryParagraph),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MainText(
                          text: auction.openingPrice,
                          style: AppTextStyles.bodySMed
                              .copyWith(color: AppColors.kPrimary),
                        ),
                        const SizedBox(width: 4),
                        SvgPicture.asset(
                          AppSvg.saudiArabiaSymbol,
                          color: AppColors.textPrimary,
                          height: 14,
                          width: 14,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainText(
                  text: AppStrings.orderNumber.tr,
                  style: AppTextStyles.bodyXsReq
                      .copyWith(color: const Color.fromRGBO(162, 162, 162, 1)),
                ),
                const SizedBox(width: 4),
                MainText(
                  text: auction.productId.toString(),
                  style: AppTextStyles.bodySReq
                      .copyWith(color: const Color.fromRGBO(116, 116, 116, 1)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
