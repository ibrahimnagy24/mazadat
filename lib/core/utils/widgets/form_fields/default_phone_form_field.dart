import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../assets/app_svg.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/radius/app_radius.dart';
import '../../../theme/text_styles/text_styles.dart';

import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import '../../validations/validator.dart';
import 'default_form_field.dart';

class DefaultPhoneFormField extends StatelessWidget {
  const DefaultPhoneFormField({
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
      titleText: AppStrings.mobileNumber.tr,
      hintStyle: AppTextStyles.textLgRegular
          .copyWith(color: const Color.fromRGBO(162, 162, 162, 1)),
      style: AppTextStyles.textMdMedium.copyWith(color: AppColors.kBlack),
      titleStyle: AppTextStyles.textMdRegular
          .copyWith(color: const Color.fromRGBO(92, 92, 92, 1)),
      prefixIcon: Container(
        width: 64,
        height: 53,
        margin: const EdgeInsetsDirectional.only(
          top: 1,
          bottom: 1,
          start: .5,
          end: 8,
        ),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(AppRadius.rS),
            bottomStart: Radius.circular(AppRadius.rS),
          ),
          border: Border(
            left: BorderSide(color: AppColors.borderNeutralSecondary, width: 1),
            right:
                BorderSide(color: AppColors.borderNeutralSecondary, width: 1),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        alignment: AlignmentDirectional.center,
        child: SvgPicture.asset(AppSvg.saudiArabiaFlag),
      ),
      hintText: '${AppStrings.enterYourPhone.tr}...',
      validator: (value) => PhoneValidator.phoneValidator(value),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      maxLength: 9,
      fillColor: const Color.fromRGBO(255, 255, 255, 1),
      borderRadius: borderRadius ?? AppRadius.rS,
      keyboardType: TextInputType.phone,
      controller: controller,
      needValidation: needValidation,
      readOnly: readOnly,
      suffixIcon: suffixWidget,
    );
  }
}
