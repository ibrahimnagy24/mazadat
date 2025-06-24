import 'package:flutter/material.dart';

import '../text/main_text.dart';
import '../../../theme/colors/styles.dart';

class DefaultTextButton extends StatelessWidget {
  const DefaultTextButton({
    super.key,
    this.fontColor,
    this.fontSize,
    this.fontWeight,
    this.hoverColor,
    this.onPressed,
    this.text,
    this.textAlign,
    this.padding,
    this.style,
    this.decorationColor,
    this.decorationThickness,
  });
  final String? text;
  final void Function()? onPressed;
  final Color? hoverColor;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final TextAlign? textAlign;
  final double? fontSize;
  final WidgetStateProperty<EdgeInsetsGeometry?>? padding;
  final TextStyle? style;
  final Color? decorationColor;
  final double? decorationThickness;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {},
      child: MainText(
        text: text ?? 'View ALL',
        style: style,
        fontSize: fontSize,
        color: fontColor ?? AppColors.kPrimary700,
        fontWeight: fontWeight ?? FontWeight.w500,
        textAlign: textAlign,
        decoration: TextDecoration.underline,
        decorationColor: decorationColor,
        decorationThickness: decorationThickness,
      ),
    );
  }
}
