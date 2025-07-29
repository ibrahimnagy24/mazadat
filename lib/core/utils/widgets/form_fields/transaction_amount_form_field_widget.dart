import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../assets/app_images.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/radius/app_radius.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import 'default_form_field.dart';

class TransactionAmountFormFieldWidget extends StatelessWidget {
  const TransactionAmountFormFieldWidget({
    super.key,
    //default 14.sp
    this.titleFontSize,
    //default 14.sp
    this.hintFontSize,
    //default 24.sp
    this.titleIconSize,
    //default 24.r
    this.borderRadius,
    this.controller,
    this.readOnly = false,
    this.needValidation,
    this.suffixWidget,
  });
  final double? titleFontSize;
  final double? hintFontSize;
  final double? titleIconSize;
  final double? borderRadius;
  final TextEditingController? controller;
  final bool readOnly;
  final bool? needValidation;
  final Widget? suffixWidget;
  @override
  Widget build(BuildContext context) {
    return DefaultFormField(
      // titleText: AppStrings.selectTheShippingAmount.tr,
      hintStyle: AppTextStyles.textMdRegular,
      style: AppTextStyles.textMdMedium.copyWith(color: AppColors.kBlack),
      // titleStyle: AppTextStyles.displaySMMedium,
      prefixIcon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.money,
            height: 20,
            width: 20,
          ),
        ],
      ),
      hintText: '100,000,000',
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      needValidation: needValidation ?? true,
      borderRadius: borderRadius ?? AppRadius.rS,
      keyboardType: TextInputType.number,
      controller: controller,
      readOnly: readOnly,
      suffixIcon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.saudiRiyalSymbol3,
            height: 18,
            width: 18,
          ),
        ],
      ),
      fillColor: const Color.fromRGBO(255, 255, 255, 0.5),
      borderColor: AppColors.borderNeutralSecondary,
      foucsBorderColor: AppColors.kPrimary,
      validator: (value) => value == null || value.isEmpty
          ? AppStrings.pleaseSpecifyTheShippingValue.tr
          : null,
      // contentPadding: EdgeInsetsDirectional.fromSTEB(24.r, 10, 10, 10),
    );
  }
}
