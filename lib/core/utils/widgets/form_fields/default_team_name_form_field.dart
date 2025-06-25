import 'package:flutter/material.dart';

import '../../../theme/text_styles/text_styles.dart';
import 'default_form_field.dart';

class DefaultTeamNameFormField extends StatelessWidget {
  const DefaultTeamNameFormField({
    super.key,
    //default 14
    this.titleFontSize,
    //default 14
    this.hintFontSize,
    //default 24
    this.titleIconSize,
    //default 24
    this.borderRadious,
    this.controller,
    this.needTitle = false,
    this.needIconTitle = false,
    this.onChanged,
    this.onSaved,
    this.onTapOutside,
    this.onFieldSubmitted,
  });
  final double? titleFontSize;
  final double? hintFontSize;
  final double? titleIconSize;
  final double? borderRadious;
  final TextEditingController? controller;
  final bool needTitle;
  final bool needIconTitle;
  final Function(String value)? onChanged;
  final void Function(String? value)? onSaved;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return DefaultFormField(
      titleText: needTitle ? 'AppStrings.userName.tr' : null,
      // titleIconWidget: needIconTitle
      //     ? Padding(
      //         padding: const EdgeInsetsDirectional.only(end: 10),
      //         child: SvgPicture.asset(
      //           AppSvg.userIconWithBackground,
      //           height: titleIconSize ?? 24,
      //           width: titleIconSize ?? 24,
      //         ),
      //       )
      //     : null,
      hintStyle: AppTextStyles.balooBhaijaan2W400Size14GreyText3.copyWith(
        fontSize: hintFontSize ?? 14,
      ),
      style: AppTextStyles.balooBhaijaan2W400Size14KPrimary1000.copyWith(
        fontSize: titleFontSize ?? 14,
      ),
      titleStyle: AppTextStyles.balooBhaijaan2W400Size14KPrimary1000.copyWith(
        fontSize: titleFontSize ?? 14,
      ),
      hintText: '${'AppStrings.teamName.tr'}...',
      // validator: (value) => validateEmail(value),
      borderRadius: borderRadious ?? 24,
      keyboardType: TextInputType.name,
      controller: controller,
      onChanged: onChanged,
      onSaved: onSaved,
      autovalidateMode: AutovalidateMode.disabled,
      onTapOutside: onTapOutside,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
