import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/text_styles/text_styles.dart';

import 'default_form_field.dart';

class DefaultGamePlayerNumberFormField extends StatelessWidget {
  const DefaultGamePlayerNumberFormField({
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
  });
  final double? titleFontSize;
  final double? hintFontSize;
  final double? titleIconSize;
  final double? borderRadious;
  final TextEditingController? controller;
  final bool needTitle;
  final bool needIconTitle;

  @override
  Widget build(BuildContext context) {
    return DefaultFormField(
      titleText: needTitle ? 'AppStrings.numberOfPlayers.tr' : null,
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
      hintText: '${'AppStrings.theAllowedNumberOfPlayersIsFrom2To10.tr'}...',
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TextInputFormatter.withFunction((oldValue, newValue) {
          final text = newValue.text;

          // Allow empty input
          if (text.isEmpty) {
            return newValue;
          }

          // Check if the input is a valid number
          if (int.tryParse(text) == null) {
            return oldValue; // Reject non-numeric input
          }

          // Parse the number
          final number = int.parse(text);

          // Check if the number is within the range 2 to 10 (1 is not accepted)
          if (number <= 10) {
            return newValue;
          }

          // Reject the input if it's outside the range
          return oldValue;
        }),
      ],
      borderRadious: borderRadious ?? 24,
      keyboardType: TextInputType.number,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'AppStrings.thisFieldIsRequired.tr';
        }
        if (int.parse(value) < 1) {
          return 'AppStrings.theAllowedNumberOfPlayersIsFrom2To10.tr';
        }
        if (int.parse(value) == 1) {
          return 'AppStrings.theAllowedNumberOfPlayersIsFrom2To10.tr';
        }
        if (int.parse(value) > 10) {
          return 'AppStrings.theAllowedNumberOfPlayersIsFrom2To10.tr';
        }
        return null;
      },
    );
  }
}
