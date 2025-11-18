import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../data/entity/view_auction_details_entity.dart';
import 'auction_dates_component.dart';
import 'auction_estimated_value_component.dart';

class AuctionEstimatedValueOrDatesComponent extends StatelessWidget {
  const AuctionEstimatedValueOrDatesComponent({
    super.key,
    required this.auction,
  });

  final ViewAuctionDetailsEntity auction;

  @override
  Widget build(BuildContext context) {
    if (auction.cancellationReason != null) {
      return _buildCancellationInfo();
    }

    if (auction.isStarted == true &&
        auction.isEnded == true &&
        auction.isJoined &&
        auction.shipment != null) {
      return _buildPurchaseValue();
    }
    
    if (auction.startDate != null &&
        auction.endDate != null &&
        auction.paymentDeadline != null) {
      return const SizedBox.shrink();
    }
    
    return auction.isStarted && auction.isEnded == false
        ? AuctionEstimatedValueComponent(auction: auction)
        : AuctionDatesComponent(auction: auction);
  }

  Widget _buildCancellationInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainText(
          text: AppStrings.auctionDate.tr,
          style: AppTextStyles.textLgBold
              .copyWith(color: const Color.fromRGBO(46, 46, 46, 1)),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SvgPicture.asset(
                      AppSvg.money,
                      height: 14.5,
                      width: 14.5,
                    ),
                  ),
                  const SizedBox(width: 6),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.insuranceAmount.tr,
                          style: AppTextStyles.textMdRegular.copyWith(
                            color: const Color.fromRGBO(162, 162, 162, 1),
                          ),
                        ),
                        const WidgetSpan(child: SizedBox(width: 4)),
                        TextSpan(
                          text: auction.insurancePrice.toString(),
                          style: AppTextStyles.bodyXsMed.copyWith(
                            color: const Color.fromRGBO(81, 94, 50, 1),
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    AppSvg.saudiArabiaSymbol,
                    height: 20,
                    width: 20,
                    color: const Color.fromRGBO(81, 94, 50, 1),
                  ),
                ],
              ),
            ),
            MainText(
              text: auction.insuranceRefunded
                  ? AppStrings.recovered.tr
                  : AppStrings.notRefunded.tr,
              style: AppTextStyles.textMdBold
                  .copyWith(color: const Color.fromRGBO(69, 173, 34, 1)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        MainText(
          text: AppStrings.reasonForCancellation.tr,
          style: AppTextStyles.textLgBold
              .copyWith(color: const Color.fromRGBO(46, 46, 46, 1)),
        ),
        const SizedBox(height: 12),
        MainText(
          text: auction.cancellationReason!,
          style: AppTextStyles.textMdRegular
              .copyWith(color: const Color.fromRGBO(162, 162, 162, 1)),
        )
      ],
    );
  }

  Widget _buildPurchaseValue() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainText(
          text: AppStrings.purchaseValue.tr,
          style: AppTextStyles.textLgBold
              .copyWith(color: const Color.fromRGBO(46, 46, 46, 1)),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SvgPicture.asset(
                AppSvg.money,
                height: 14.5,
                width: 14.5,
              ),
            ),
            const SizedBox(width: 6),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: AppStrings.purchasePrice.tr,
                    style: AppTextStyles.textMdRegular.copyWith(
                      color: const Color.fromRGBO(162, 162, 162, 1),
                    ),
                  ),
                  const WidgetSpan(child: SizedBox(width: 4)),
                  TextSpan(
                    text: auction.shipment!.totalAmount.toString(),
                    style: AppTextStyles.bodyXsMed.copyWith(
                      color: const Color.fromRGBO(81, 94, 50, 1),
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              AppSvg.saudiArabiaSymbol,
              height: 20,
              width: 20,
              color: const Color.fromRGBO(81, 94, 50, 1),
            ),
          ],
        ),
      ],
    );
  }
}
