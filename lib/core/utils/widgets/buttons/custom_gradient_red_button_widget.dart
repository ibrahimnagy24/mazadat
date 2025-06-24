import 'package:flutter/material.dart';

import '../../../theme/text_styles/text_styles.dart';

import 'custom_button_with_inner_shadow_widget.dart';

class CustomGradientRedButtonWidget extends StatelessWidget {
  const CustomGradientRedButtonWidget({
    super.key,
    this.onPressed,
    this.text,
    this.boxShadow,
    this.onPressedBoxShadow,
    this.color,
    this.isLoading = false,
    this.isActive = true,
  });
  final Function()? onPressed;
  final String? text;
  final List<BoxShadow>? onPressedBoxShadow;
  final List<BoxShadow>? boxShadow;
  final Color? color;
  final bool isLoading;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return CustomButtonWithInnerShadowWidget(
      onPressed: isActive ? onPressed : () {},
      isLoading: isLoading,
      text: text ?? 'AppStrings.wrongAnswer.tr',
      textStyle:
          AppTextStyles.balooBhaijaan2W500Size15KWhite.copyWith(fontSize: 15),
      color: !isActive
          ? const Color(0xFFBFBFBF)
          : color ?? const Color.fromRGBO(208, 4, 22, 0.64),
      onPressedBoxShadow: isActive
          ? onPressedBoxShadow ??
              const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  offset: Offset(0, 0),
                ),
                BoxShadow(
                  color: Color.fromRGBO(208, 4, 22, 1),
                  blurRadius: 16,
                  offset: Offset(0, 0),
                ),
              ]
          : [],
      boxShadow: isActive
          ? boxShadow ??
              const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                  offset: Offset(0, 0),
                ),
                BoxShadow(
                  color: Color.fromRGBO(208, 4, 22, 1),
                  blurRadius: 3,
                  offset: Offset(0, 0),
                ),
              ]
          : [],
    );
  }
}
