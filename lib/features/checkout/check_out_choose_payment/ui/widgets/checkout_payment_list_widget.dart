import 'package:flutter/material.dart';

import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../../core/utils/widgets/misc/custom_network_image.dart';
import '../../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../data/entity/checkout_payment_entity.dart';

class CheckoutPaymentListWidget extends StatefulWidget {
  const CheckoutPaymentListWidget({
    super.key,
    required this.paymentMethods,
    this.onPaymentMethodSelected,
    this.selectedPaymentMethodId,
    this.needToShowWalletOption = true,
    this.walletBalance,
  });

  const CheckoutPaymentListWidget.loading({
    super.key,
  })  : paymentMethods = const [],
        onPaymentMethodSelected = null,
        selectedPaymentMethodId = null,
        needToShowWalletOption = true,
        walletBalance = null;

  final List<CheckoutPaymentMethodEntity> paymentMethods;
  final Function(CheckoutPaymentMethodEntity)? onPaymentMethodSelected;
  final int? selectedPaymentMethodId;
  final bool needToShowWalletOption;
  final String? walletBalance;

  @override
  State<CheckoutPaymentListWidget> createState() =>
      _CheckoutPaymentListWidgetState();
}

class _CheckoutPaymentListWidgetState extends State<CheckoutPaymentListWidget> {
  @override
  Widget build(BuildContext context) {
    // Show loading shimmer
    if (widget.paymentMethods.isEmpty &&
        widget.onPaymentMethodSelected == null) {
      return _buildLoadingShimmer();
    }

    // Filter payment methods if needed
    List<CheckoutPaymentMethodEntity> filteredPaymentMethods =
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
    CheckoutPaymentMethodEntity paymentMethod,
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
                ? const Color.fromRGBO(255, 255, 255, 0.5)
                : AppColors.scaffoldBackground,
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color.fromRGBO(81, 94, 50, 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: AppTextStyles.textLgMedium.copyWith(
                        color: isSelected
                            ? AppColors.kPrimary
                            : AppColors.textPrimary,
                      ),
                      child: Text(
                        paymentMethod.name,
                      ),
                    ),
                    if (paymentMethod.type == 'WALLET' && widget.walletBalance != null) ...[
                    const SizedBox(height: 4),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: AppTextStyles.textSmRegular.copyWith(
                        color: AppColors.kGeryText3,
                      ),
                      child: Text(
                        'الرصيد: ${widget.walletBalance} ر.س',
                      ),
                    ),
                  ] else if (paymentMethod.nameEn.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: AppTextStyles.textSmRegular.copyWith(
                          color: AppColors.kGeryText3,
                        ),
                        child: Text(
                          paymentMethod.nameEn,
                        ),
                      ),
                    ],
                  ],
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
