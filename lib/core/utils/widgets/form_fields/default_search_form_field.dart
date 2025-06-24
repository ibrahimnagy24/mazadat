import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../assets/app_svg.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/radiuos/app_radiuos.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import '../../validations/vaildator.dart';
import 'default_form_field.dart';

class DefaultSearchFormField extends StatelessWidget {
  const DefaultSearchFormField({
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
      titleText: AppStrings.lookingForAuctions.tr,
      hintStyle: AppTextStyles.bodySReq.copyWith(
        fontSize: hintFontSize ?? 14,
        color: AppColors.kGeryText2,
      ),
      style: AppTextStyles.bodyXsReq.copyWith(
        fontSize: titleFontSize ?? 14,
        color: AppColors.kPrimary900,
      ),
      titleStyle: AppTextStyles.bodyXsReq.copyWith(
        fontSize: titleFontSize,
        color: AppColors.kGeryText,
      ),
      hintText: AppStrings.lookingForAuctions.tr,
      validator: needValidation
          ? (value) => EmailValidator.emailValidator(value)
          : null,
      borderRadious: borderRadious ?? AppRadiuos.rS,
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      onTapOutside: (p0) {},
      readOnly: readOnly,
      needValidation: needValidation,
      enabledBorderColor: AppColors.kGeryText8,
      foucsBorderColor: AppColors.kPrimary500,
      inactiveBorderColor: AppColors.kGeryText8,
      prefixIcon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppSvg.searchIcon,
            height: 20,
            width: 20,
            fit: BoxFit.contain,
          ),
        ],
      ),
      suffixIcon: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(AppSvg.filterIcon),
      ),
    );
  }
}
