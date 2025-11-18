import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/services/toast_service.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../cubit/shipment_details_cubit.dart';
import '../../cubit/shipment_details_state.dart';

class ShipmentPurchaseDetailsWidget extends StatelessWidget {
  const ShipmentPurchaseDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShipmentDetailsCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MainText(
              text: AppStrings.purchaseDetails.tr,
              style:
                  AppTextStyles.textLgBold.copyWith(color: AppColors.mainDark),
            ),
            BlocConsumer<ShipmentDetailsCubit, ShipmentDetailsState>(
              listener: (context, state) {
                if (state is DownloadInvoiceError) {
                  ToastService.showError(state.error.message, context);
                }
              },
              buildWhen: (previous, current) =>
                  current is DownloadInvoiceLoading ||
                  current is DownloadInvoiceSuccess ||
                  current is DownloadInvoiceError,
              builder: (context, state) {
                return GestureDetector(
                  onTap: state is DownloadInvoiceLoading
                      ? null
                      : () {
                          cubit.downloadInvoiceStatesHandled();
                        },
                  child: Row(
                    children: [
                      if (state is DownloadInvoiceLoading)
                        const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      else
                        SvgPicture.asset(
                          AppSvg.download,
                          height: 16,
                          width: 16,
                        ),
                      const SizedBox(width: 8),
                      MainText(
                        text: AppStrings.downloadInvoice.tr,
                        style: AppTextStyles.textMdSemibold.copyWith(
                          color: state is DownloadInvoiceLoading
                              ? const Color.fromRGBO(162, 162, 162, 1)
                              : const Color.fromRGBO(81, 94, 50, 1),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildPurchaseElement(
                  AppStrings.productPrice.tr,
                  cubit.shipmentDetails!.data.productPrice.toString(),
                ),
                const SizedBox(height: 9),
                _buildPurchaseElement(
                  AppStrings.insuranceAmount.tr,
                  cubit.shipmentDetails!.data.insurancePrice.toString(),
                ),
                const SizedBox(height: 9),
                _buildPurchaseElement(
                  AppStrings.applicationPercentage.tr,
                  cubit.shipmentDetails!.data.appCommissionAmount,
                ),
                const SizedBox(height: 9),
                _buildPurchaseElement(
                  AppStrings.deliveryPrice.tr,
                  cubit.shipmentDetails!.data.deliveryPrice.toString(),
                ),
                const SizedBox(height: 9),
                _buildPurchaseElement(
                  AppStrings.totalWithoutVat.tr,
                  cubit.shipmentDetails!.data.totalAmountNoVat.toString(),
                ),
                const SizedBox(height: 9),
                _buildPurchaseElement(
                  AppStrings.addedValue.tr,
                  cubit.shipmentDetails!.data.vatAmount.toString(),
                ),
                const SizedBox(height: 9),
                const Divider(
                  color: Color.fromRGBO(232, 232, 232, 1),
                ),
                const SizedBox(height: 9),
                _buildPurchaseElement(
                  AppStrings.totalPrice.tr,
                  cubit.shipmentDetails!.data.totalAmount.toString(),
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
