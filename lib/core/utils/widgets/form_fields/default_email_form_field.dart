import 'package:flutter/material.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/radiuos/app_radiuos.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import '../../validations/vaildator.dart';
import 'default_form_field.dart';

class DefaultEmailFormField extends StatelessWidget {
  const DefaultEmailFormField({
    super.key,
    //default 14.sp
    this.titleFontSize,
    //default 14.sp
    this.hintFontSize,
    //default 24.sp
    this.titleIconSize,
    //default 24.r
    this.borderRadious,
    this.controller,
    this.readOnly = false,
    this.needValidation = true,
  });
  final double? titleFontSize;
  final double? hintFontSize;
  final double? titleIconSize;
  final double? borderRadious;
  final TextEditingController? controller;
  final bool readOnly;
  final bool needValidation;
  @override
  Widget build(BuildContext context) {
    return DefaultFormField(
      titleText: AppStrings.theEmail.tr,
      // titleIconWidget: Padding(
      //   padding: EdgeInsetsDirectional.only(end: 10.r),
      //   child: SvgPicture.asset(
      //     AppSvg.emailIconWithBackground,
      //     height: titleIconSize ?? 24.h,
      //     width: titleIconSize ?? 24.w,
      //   ),
      // ),
      hintStyle: AppTextStyles.balooBhaijaan2W400Size14GreyText3.copyWith(
        fontSize: hintFontSize ?? 14,
      ),
      style: AppTextStyles.bodyXsReq.copyWith(
        fontSize: titleFontSize ?? 14,
        color: AppColors.kPrimary900,
      ),
      titleStyle: AppTextStyles.bodyXsReq.copyWith(
        fontSize: titleFontSize,
        color: AppColors.kGeryText,
      ),
      hintText: '${AppStrings.enterYourEmail.tr}...',
      validator: needValidation
          ? (value) => EmailValidator.emailValidator(value)
          : null,
      borderRadious: borderRadious ?? AppRadiuos.rS,
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      onTapOutside: (p0) {},
      readOnly: readOnly,
      needValidation: needValidation,
    );
  }
}
