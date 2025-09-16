import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../cubit/checkout_summary_cubit.dart';

class CheckoutDeliveryAddressWidget extends StatelessWidget {
  const CheckoutDeliveryAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutSummaryCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainText(
          text: AppStrings.deliveryAddress.tr,
          style: AppTextStyles.textLgBold.copyWith(color: AppColors.mainDark),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border.all(
              color: AppColors.borderNeutralSecondary,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                AppSvg.location,
                width: 24,
                height: 24,
                color: AppColors.iconDefault,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cubit.checkoutSummary!.data.shipmentAddress.addressType
                          .name,
                      style: AppTextStyles.textLgRegular.copyWith(
                          color: const Color.fromRGBO(116, 116, 116, 1)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      cubit.checkoutSummary!.data.shipmentAddress.description,
                      style: AppTextStyles.textMdRegular.copyWith(
                          color: const Color.fromRGBO(162, 162, 162, 1)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
