import 'package:flutter/material.dart';
import '../../../theme/colors/styles.dart';

class MainText extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  final double? fontSize;
  final double? textHeight;
  final Color? color;
  // final String? fontFamily;
  final TextDirection? textDirection;
  final double? horPadding;
  final double? verPadding;
  final TextDecoration? decoration;
  final int? maxLines;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final Function()? onTap;
  final TextStyle? style;
  final TextOverflow? overflow;
  final EdgeInsetsGeometry? padding;
  final Color? decorationColor;
  final double? decorationThickness;
  const MainText({
    super.key,
    required this.text,
    this.textAlign,
    this.fontSize,
    this.color,
    // this.fontFamily,
    this.textDirection,
    this.textHeight,
    this.horPadding,
    this.verPadding,
    this.decoration,
    this.maxLines,
    this.fontWeight,
    this.letterSpacing,
    this.onTap,
    this.style,
    this.overflow,
    this.padding,
    this.decorationColor,
    this.decorationThickness,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
                horizontal: horPadding ?? 0, vertical: verPadding ?? 0),
        child: Text(
          text ?? '',
          textAlign: textAlign,
          textDirection: textDirection,
          maxLines: maxLines,
          overflow: overflow,
          style: style ??
              TextStyle(
                // height: textHeight ?? 1.5,
                fontSize: fontSize,
                overflow: TextOverflow.ellipsis,
                fontWeight: fontWeight,
                color: color ?? Colors.black,
                decoration: decoration,
                fontFamily: AppColors.fontFamily,
                decorationColor: decorationColor,
                decorationThickness: decorationThickness,
              ),
        ),
      ),
    );
  }
}
