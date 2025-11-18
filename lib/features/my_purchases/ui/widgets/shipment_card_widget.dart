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
import '../../data/entity/shipment_entity.dart';

class ShipmentCardWidget extends StatelessWidget {
  const ShipmentCardWidget({
    super.key,
    this.onTap,
    this.height = 207,
    required this.shipment,
  });

  final void Function()? onTap;
  final double height;
  final ShipmentEntity shipment;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                // Display product image if available
                shipment.auction.productImages.isNotEmpty
                    ? DefaultNetworkImage(
                        shipment.auction.productImages.first.path,
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
                            Icons.inventory_2_outlined,
                            size: 48,
                            color: AppColors.textSecondaryParagraph,
                          ),
                        ),
                      ),
                if (shipment.status.isNotEmpty)
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
                        shipment.status,
                        style: AppTextStyles.textMdRegular
                            .copyWith(color: AppColors.textPrimary),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (shipment.totalAmount != null &&
                shipment.totalAmount!.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainText(
                    text: AppStrings.totalPrice.tr,
                    style: AppTextStyles.bodyXXsReq
                        .copyWith(color: AppColors.textSecondaryParagraph),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MainText(
                          text: shipment.totalAmount!,
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
            _ShipmentInfo(
              orderNumber: shipment.orderNumber,
              shipmentId: shipment.id,
            ),
          ],
        ),
      ),
    );
  }
}

class _ShipmentInfo extends StatelessWidget {
  const _ShipmentInfo({
    required this.orderNumber,
    required this.shipmentId,
  });

  final String orderNumber;
  final int shipmentId;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainText(
          text: AppStrings.orderNumber.tr,
          style: AppTextStyles.bodyXsReq
              .copyWith(color: const Color.fromRGBO(162, 162, 162, 1)),
        ),
        const SizedBox(width: 4),
        MainText(
          text: orderNumber,
          style: AppTextStyles.bodySReq
              .copyWith(color: const Color.fromRGBO(116, 116, 116, 1)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
