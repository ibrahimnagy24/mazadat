import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../assets/app_svg.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/radiuos/app_radiuos.dart';
import '../../../theme/text_styles/text_styles.dart';

import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import '../../validations/vaildator.dart';
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
          color: AppColors.kOpacityGrey,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(AppRadiuos.rS),
            bottomStart: Radius.circular(AppRadiuos.rS),
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
      borderRadious: borderRadious ?? AppRadiuos.rS,
      keyboardType: TextInputType.phone,
      controller: controller,
      needValidation: needValidation,
      onTapOutside: (p0) {},
      readOnly: readOnly,
      // contentPadding: EdgeInsetsDirectional.fromSTEB(24.r, 10, 10, 10),
    );
  }
}
