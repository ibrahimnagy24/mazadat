import 'package:flutter/material.dart';

import '../../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../../core/utils/widgets/misc/custom_network_image.dart';
import '../../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../data/entity/bundle_payment_entity.dart';

class BundlePaymentListWidget extends StatefulWidget {
  const BundlePaymentListWidget({
    super.key,
    required this.paymentMethods,
    this.onPaymentMethodSelected,
    this.selectedPaymentMethodId,
    this.needToShowWalletOption = true,
    this.walletBalance,
  });

  const BundlePaymentListWidget.loading({
    super.key,
  })  : paymentMethods = const [],
        onPaymentMethodSelected = null,
        selectedPaymentMethodId = null,
        needToShowWalletOption = true,
        walletBalance = null;

  final List<BundlePaymentMethodEntity> paymentMethods;
  final Function(BundlePaymentMethodEntity)? onPaymentMethodSelected;
  final int? selectedPaymentMethodId;
  final bool needToShowWalletOption;
  final String? walletBalance;

  @override
  State<BundlePaymentListWidget> createState() =>
      _BundlePaymentListWidgetState();
}

class _BundlePaymentListWidgetState extends State<BundlePaymentListWidget> {
  @override
  Widget build(BuildContext context) {
    // Show loading shimmer
    if (widget.paymentMethods.isEmpty &&
        widget.onPaymentMethodSelected == null) {
      return _buildLoadingShimmer();
    }

    // Filter payment methods if needed
    List<BundlePaymentMethodEntity> filteredPaymentMethods =
        List.from(widget.paymentMethods);

    if (!widget.needToShowWalletOption) {
      filteredPaymentMethods.removeWhere(
        (element) => element.type.toUpperCase() == 'WALLET',
      );
    }

    return ListAnimator(
      data: List.generate(
        filteredPaymentMethods.length,
        (index) => _buildPaymentMethodItem(
          filteredPaymentMethods[index],
          index,
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return ListAnimator(
      data: List.generate(
        5,
        (i) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: CustomShimmerContainer(
            height: 60,
            width: MediaQueryHelper.width,
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodItem(
    BundlePaymentMethodEntity paymentMethod,
    int index,
  ) {
    final isSelected = widget.selectedPaymentMethodId == paymentMethod.id;

    return AnimatedScale(
      scale: isSelected ? 1.02 : 1.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: GestureDetector(
        onTap: () {
          widget.onPaymentMethodSelected?.call(paymentMethod);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? const Color.fromRGBO(81, 94, 50, 1)
                  : AppColors.border,
              width: isSelected ? 2 : 1,
            ),
            color: isSelected
                ? AppColors.scaffoldBackground
                : const Color.fromRGBO(255, 255, 255, 0.5),
            boxShadow: isSelected
                ? [
                    const BoxShadow(
                      color: Color.fromRGBO(81, 94, 50, 0.2),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          width: MediaQueryHelper.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Payment method icon
              CustomNetworkImage.containerNewWorkImage(
                image: paymentMethod.icon ?? '',
                width: 32,
                height: 32,
                radius: 8,
              ),
              const SizedBox(width: 12),

              // Payment method name
              Expanded(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: AppTextStyles.textLgMedium.copyWith(
                    color:
                        isSelected ? AppColors.kPrimary : AppColors.textPrimary,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          paymentMethod.name,
                          style: isSelected
                              ? AppTextStyles.textLgBold.copyWith(
                                  color: const Color.fromRGBO(81, 94, 50, 1))
                              : AppTextStyles.textLgRegular.copyWith(
                                  color:
                                      const Color.fromRGBO(116, 116, 116, 1)),
                        ),
                      ),
                      if (paymentMethod.type == 'WALLET' &&
                          widget.walletBalance != null)
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: AppTextStyles.textSmRegular
                              .copyWith(color: AppColors.kGeryText3),
                          child: Text(
                            mainAppBloc.isArabic
                                ? 'الرصيد: ${widget.walletBalance} ر.س'
                                : 'Balance: ${widget.walletBalance} SR',
                            style: isSelected
                                ? AppTextStyles.textLgBold.copyWith(
                                    color: const Color.fromRGBO(81, 94, 50, 1))
                                : AppTextStyles.textLgRegular.copyWith(
                                    color:
                                        const Color.fromRGBO(116, 116, 116, 1)),
                          ),
                        ),
                      if (paymentMethod.type == 'WALLET' &&
                          widget.walletBalance != null)
                        const SizedBox(width: 4),
                    ],
                  ),
                ),
              ),

              // Selection indicator with animation
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  key: ValueKey(isSelected),
                  size: 24,
                  color:
                      isSelected ? AppColors.kPrimary : AppColors.iconDefault,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
