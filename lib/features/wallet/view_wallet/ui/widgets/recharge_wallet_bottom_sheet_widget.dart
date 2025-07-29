import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../../../core/assets/app_images.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/radius/app_radius.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../../core/utils/widgets/form_fields/transaction_amount_form_field_widget.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import 'recharge_wallet_status_widget.dart';

class RechargeWalletBottomSheetWidget extends StatefulWidget {
  const RechargeWalletBottomSheetWidget({
    super.key,
    required this.dialogContext,
  });
  final BuildContext dialogContext;
  @override
  State<RechargeWalletBottomSheetWidget> createState() =>
      _RechargeWalletBottomSheetWidgetState();
}

class _RechargeWalletBottomSheetWidgetState
    extends State<RechargeWalletBottomSheetWidget> {
  int _selectedPaymentMethod = 0;
  late TextEditingController _transactionAmountController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _transactionAmountController = TextEditingController();
  }

  @override
  void dispose() {
    _transactionAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 460,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 5,
                width: 60,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.greyScale900,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            MainText(
              text: AppStrings.selectTheShippingAmount.tr,
              style: AppTextStyles.displaySMMedium,
            ),
            const SizedBox(height: 12),
            TransactionAmountFormFieldWidget(
              controller: _transactionAmountController,
            ),
            const SizedBox(height: 16),
            MainText(
              text: AppStrings.selectTheShippingAmount.tr,
              style: AppTextStyles.displaySMMedium,
            ),
            const SizedBox(height: 16),
            _buildPaymentMethodOptions(),
            const SizedBox(height: 48),
            DefaultButton(
              text: AppStrings.charge.tr,
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                Navigator.pop(widget.dialogContext);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  barrierColor: Colors.transparent,
                  builder: (dialogContext) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: RechargeWalletStatusWidget(
                        dialogContext: dialogContext,
                        isTransactionSuccess:
                            _selectedPaymentMethod == 0 ? true : false,
                      ),
                    );
                  },
                );
              },
              backgroundColor: AppColors.buttonBackgroundPrimaryDefault,
              textColor: AppColors.kWhite,
              textStyle: AppTextStyles.textXLBold,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodOptions() {
    return Column(
      children: [
        // Apple Pay Option
        _buildPaymentMethodTile(
          index: 0,
          title: AppStrings.applePay.tr,
          imageAsset: AppImages.applePayIcon,
        ),
        const SizedBox(height: 12),
        // Visa Option
        _buildPaymentMethodTile(
          index: 1,
          title: AppStrings.visa.tr,
          imageAsset: AppImages.visaIcon,
        ),
      ],
    );
  }

  Widget _buildPaymentMethodTile(
      {required int index, required String title, required String imageAsset}) {
    final bool isSelected = _selectedPaymentMethod == index;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          border: Border.all(
            color: isSelected ? AppColors.kPrimary : AppColors.borderDefault,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppRadius.rS),
        ),
        child: Row(
          children: [
            // Leading image
            Image.asset(
              imageAsset,
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 16),
            // Title
            Text(
              title,
              style: AppTextStyles.textLgMedium,
            ),
            const Spacer(),
            // Trailing circular checkbox
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected ? AppColors.kPrimary : AppColors.borderDefault,
                  width: 2,
                ),
                color: isSelected ? AppColors.kPrimary : Colors.transparent,
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
