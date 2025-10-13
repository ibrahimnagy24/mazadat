import 'package:flutter/material.dart';
import '../../../theme/radius/app_radius.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import '../../validations/validator.dart';
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
    this.fillColor,
    this.style,
    this.titleStyle,
    this.hintStyle,
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
  final Color? fillColor;
  final TextStyle? style;
  final TextStyle? titleStyle;
  final TextStyle? hintStyle;
  @override
  Widget build(BuildContext context) {
    return DefaultFormField(
      titleText: needUserName ? titleText ?? AppStrings.userName.tr : null,
      hintText: hintText ?? AppStrings.enterYourName.tr,
      borderRadius: borderRadious ?? AppRadius.rS,
      keyboardType: TextInputType.name,
      controller: controller,
      readOnly: readonly,
      titleStyle: titleStyle ??
          AppTextStyles.textMdRegular
              .copyWith(color: const Color.fromRGBO(92, 92, 92, 1)),
      style: style ??
          AppTextStyles.textLgRegular
              .copyWith(color: const Color.fromRGBO(46, 46, 46, 1)),
      hintStyle: hintStyle,
      validator: (value) => NameValidator.nameValidator(value),
      fillColor: fillColor,
    );
  }
}
