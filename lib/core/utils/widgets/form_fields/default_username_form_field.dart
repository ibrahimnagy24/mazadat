import 'package:flutter/material.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/radiuos/app_radiuos.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import 'default_form_field.dart';

class DefaultUsernameFormField extends StatelessWidget {
  const DefaultUsernameFormField({
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
    this.readonly = false,
    this.needUserName = true,
    this.hintText,
    this.titleText,
  });
  final double? titleFontSize;
  final double? hintFontSize;
  final double? titleIconSize;
  final double? borderRadious;
  final TextEditingController? controller;
  final bool readonly;
  final bool needUserName;
  final String? titleText;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return DefaultFormField(
      titleText: needUserName ? titleText ?? AppStrings.userName.tr : null,
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
      hintText: hintText ?? '${AppStrings.enterYourName.tr}...',
      // validator: (value) => validateEmail(value),
      borderRadious: borderRadious ?? AppRadiuos.rS,
      keyboardType: TextInputType.name,
      controller: controller,
      readOnly: readonly,
    );
  }
}
