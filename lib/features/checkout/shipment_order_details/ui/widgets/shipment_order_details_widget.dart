import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/misc/default_network_image.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../cubit/shipment_details_cubit.dart';

class ShipmentOrderDetailsWidget extends StatelessWidget {
  const ShipmentOrderDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShipmentDetailsCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainText(
          text: AppStrings.productDetails.tr,
          style: AppTextStyles.textLgBold.copyWith(color: AppColors.mainDark),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 64,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: DefaultNetworkImage(
                  cubit.shipmentDetails!.data.auction.image,
                  height: 64,
                  width: 64,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainText(
                    text: cubit.shipmentDetails!.data.auction.productName,
                    style: AppTextStyles.textMdBold,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    maxLines: 1,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.auctionNumber.tr,
                          style: AppTextStyles.textSmRegular.copyWith(
                              color: const Color.fromRGBO(162, 162, 162, 1)),
                        ),
                        const WidgetSpan(child: SizedBox(width: 4)),
                        TextSpan(
                          text: cubit
                              .shipmentDetails!.data.auction.auctionNumber
                              .toString(),
                          style: AppTextStyles.textSmRegular.copyWith(
                            color: const Color.fromRGBO(46, 46, 46, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
