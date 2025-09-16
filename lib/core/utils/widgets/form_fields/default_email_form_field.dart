import 'package:flutter/material.dart';
import '../../../theme/radius/app_radius.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import '../../validations/validator.dart';
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
    this.borderRadius,
    this.controller,
    this.readOnly = false,
    this.needValidation = true,
    this.fillColor,
  });
  final double? titleFontSize;
  final double? hintFontSize;
  final double? titleIconSize;
  final double? borderRadius;
  final TextEditingController? controller;
  final bool readOnly;
  final bool needValidation;
  final Color? fillColor;
  @override
  Widget build(BuildContext context) {
    return DefaultFormField(
      titleText: AppStrings.theEmail.tr,
      hintText: '${AppStrings.enterYourEmail.tr}...',
      validator: needValidation
          ? (value) => EmailValidator.emailValidator(value)
          : null,
      borderRadius: borderRadius ?? AppRadius.rS,
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      onTapOutside: (p0) {},
      readOnly: readOnly,
      needValidation: needValidation,
      titleStyle: AppTextStyles.textMdRegular
          .copyWith(color: const Color.fromRGBO(92, 92, 92, 1)),
      style: AppTextStyles.textLgRegular
          .copyWith(color: const Color.fromRGBO(46, 46, 46, 1)),
      fillColor: fillColor,
    );
  }
}
