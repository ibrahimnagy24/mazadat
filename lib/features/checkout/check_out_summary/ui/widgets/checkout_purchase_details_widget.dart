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

class CheckoutPurchaseDetailsWidget extends StatelessWidget {
  const CheckoutPurchaseDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutSummaryCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainText(
          text: AppStrings.purchaseDetails.tr,
          style: AppTextStyles.textLgBold.copyWith(color: AppColors.mainDark),
        ),
        const SizedBox(height: 16),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildPurchaseElement(
                  AppStrings.productPrice.tr,
                  cubit.checkoutSummary!.data.productPrice.toString(),
                ),
                const SizedBox(height: 9),
                _buildPurchaseElement(
                  AppStrings.insuranceAmount.tr,
                  cubit.checkoutSummary!.data.insurancePrice.toString(),
                ),
                const SizedBox(height: 9),
                _buildPurchaseElement(
                  AppStrings.applicationPercentage.tr,
                  '${cubit.checkoutSummary!.data.appCommissionPercentage}%',
                ),
                const SizedBox(height: 9),
                _buildPurchaseElement(
                  AppStrings.deliveryPrice.tr,
                  cubit.checkoutSummary!.data.deliveryPrice.toString(),
                ),
                const SizedBox(height: 9),
                _buildPurchaseElement(
                  AppStrings.totalWithoutVat.tr,
                  cubit.checkoutSummary!.data.totalAmountNoVat.toString(),
                ),
                const SizedBox(height: 9),
                _buildPurchaseElement(
                  AppStrings.addedValue.tr,
                  cubit.checkoutSummary!.data.vatAmount.toString(),
                ),
                const SizedBox(height: 9),
                const Divider(
                  color: Color.fromRGBO(232, 232, 232, 1),
                ),
                const SizedBox(height: 9),
                _buildPurchaseElement(
                  AppStrings.totalPrice.tr,
                  cubit.checkoutSummary!.data.totalAmount.toString(),
                  titleStyle: AppTextStyles.textLgMedium
                      .copyWith(color: const Color.fromRGBO(116, 116, 116, 1)),
                  priceStyle: AppTextStyles.textLgMedium
                      .copyWith(color: const Color.fromRGBO(81, 94, 50, 1)),
                ),
                const SizedBox(height: 9),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPurchaseElement(
    String title,
    String price, {
    TextStyle? titleStyle,
    TextStyle? priceStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MainText(
          text: title,
          style: titleStyle ??
              AppTextStyles.textMdRegular.copyWith(
                color: const Color.fromRGBO(162, 162, 162, 1),
              ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MainText(
              text: price,
              style: priceStyle ??
                  AppTextStyles.textMdRegular
                      .copyWith(color: const Color.fromRGBO(81, 94, 50, 1)),
            ),
            const SizedBox(width: 3),
            SvgPicture.asset(
              AppSvg.saudiArabiaSymbol,
              width: 12,
              height: 12,
              color: const Color.fromRGBO(81, 94, 50, 1),
            ),
          ],
        )
      ],
    );
  }
}
