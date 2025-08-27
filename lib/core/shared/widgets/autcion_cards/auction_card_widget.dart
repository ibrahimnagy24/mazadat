import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../../../core/utils/widgets/timer/countdown_timer_widget.dart';
import '../../../utils/enums/enums.dart';

class AuctionCardWidget extends StatelessWidget {
  const AuctionCardWidget({
    super.key,
    this.onTap,
    this.height = 207,
    required this.image,
    this.auctionStatus,
    this.auctionType,
    this.fiananceText,
    this.fianancePrice,
    this.needFavouriteIcon = true,
    this.isFav = false,
    this.startDate,
    this.endDate,
    required this.auctionId,
  });
  final void Function()? onTap;
  final double height;
  final String image;
  final String? auctionStatus;
  final AuctionType? auctionType;
  final String? fiananceText;
  final String? fianancePrice;
  final bool needFavouriteIcon;
  final bool isFav;
  final DateTime? startDate;
  final DateTime? endDate;
  final int auctionId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: MediaQueryHelper.width,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.rXS),
          color: AppColors.fillColor,
          border: Border.all(color: AppColors.kGeryText8),
        ),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                DefaultNetworkImage(
                  image,
                  radius: AppRadius.rXXS,
                  height: 135,
                ),
                if (auctionStatus != null)
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
                          bottomEnd: Radius.circular(AppRadius.rLg),
                        ),
                        color: AppColors.backgroundSecondary,
                      ),
                      child: Text(
                        auctionStatus!,
                        style: AppTextStyles.textMdRegular
                            .copyWith(color: AppColors.textPrimary),
                      ),
                    ),
                  ),
                if (auctionType != null)
                  PositionedDirectional(
                    end: 4,
                    top: 4,
                    child: SvgPicture.asset(
                      AppSvg.auctionType(auctionType!),
                      color: AppColors.kWhite,
                      width: 24,
                      height: 24,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (fianancePrice != null || fiananceText != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainText(
                    text: fiananceText ?? AppStrings.openingPrice.tr,
                    style: AppTextStyles.bodyXXsReq
                        .copyWith(color: AppColors.textSecondaryParagraph),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MainText(
                          text: fianancePrice ?? '',
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
            const SizedBox(height: 9),
            _AuctionInfo(
              needFavouriteIcon: needFavouriteIcon,
              isFav: isFav,
              startDate: startDate,
              endDate: endDate,
            ),
          ],
        ),
      ),
    );
  }
}

class _AuctionInfo extends StatelessWidget {
  const _AuctionInfo({
    required this.needFavouriteIcon,
    required this.isFav,
    this.startDate,
    this.endDate,
  });
  final bool needFavouriteIcon;
  final bool isFav;
  final DateTime? startDate;
  final DateTime? endDate;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (startDate != null && endDate != null)
          Expanded(
            child: Row(
              children: [
                SvgPicture.asset(
                  AppSvg.timer,
                  color: AppColors.textSecondaryParagraph,
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: 6),
                if (startDate != null && endDate != null)
                  CountdownTimerWidget(
                    startDate: startDate!,
                    endTime: endDate!,
                    textStyle: AppTextStyles.textMdRegular.copyWith(
                      color: const Color.fromRGBO(69, 173, 34, 1),
                    ),
                  ),
              ],
            ),
          ),
        if (needFavouriteIcon) const SizedBox(width: 16),
        if (needFavouriteIcon)
          SvgPicture.asset(
            isFav ? AppSvg.fillFav : AppSvg.fav,
            width: 15,
            height: 15,
          ),
      ],
    );
  }
}
