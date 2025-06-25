import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../assets/app_svg.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/radiuos/app_radiuos.dart';
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
    this.borderRadious,
    this.controller,
    this.readOnly = false,
    this.needValidation,
  });
  final double? titleFontSize;
  final double? hintFontSize;
  final double? titleIconSize;
  final double? borderRadious;
  final TextEditingController? controller;
  final bool readOnly;
  final bool? needValidation;
  @override
  Widget build(BuildContext context) {
    return DefaultFormField(
      titleText: AppStrings.mobileNumber.tr,
      hintStyle: AppTextStyles.textMdRegular,
      style: AppTextStyles.textMdMedium.copyWith(color: AppColors.kBlack),
      titleStyle: AppTextStyles.textMdRegular,
      prefixIcon: Container(
        width: 64,
        height: 53,
        // margin: const EdgeInsets.symmetric(horizontal: 1.5, vertical: 1),
        margin: const EdgeInsetsDirectional.only(
          top: 1,
          bottom: 1,
          start: 1.5,
          end: 8,
        ),
        decoration: const BoxDecoration(
            color: AppColors.fillColor,
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(AppRadius.rS),
              bottomStart: Radius.circular(AppRadius.rS),
            ),
            border: Border(
              left:
                  BorderSide(color: AppColors.borderNeutralSecondary, width: 1),
              right:
                  BorderSide(color: AppColors.borderNeutralSecondary, width: 1),
            )),
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
      borderRadius: borderRadious ?? AppRadius.rS,
      keyboardType: TextInputType.phone,
      controller: controller,
      needValidation: needValidation,
      onTapOutside: (p0) {},
      readOnly: readOnly,
      // contentPadding: EdgeInsetsDirectional.fromSTEB(24.r, 10, 10, 10),
    );
  }
}
