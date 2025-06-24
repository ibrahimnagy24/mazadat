import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../theme/colors/styles.dart';

class CustomBtn extends StatelessWidget {
  final String? text;
  final GestureTapCallback? onTap;
  final Color? color, loadingColor, txtColor;
  final IconData? icon;
  final Widget? image, child;
  final double horizontalPadding;
  final double? btnWidth, btnHeight, txtFontSize, paddingWidth, radius;
  final bool loading, withPadding, onlyBorder, showTransparent, active;
  final LinearGradient? gradient;
  final EdgeInsets? padding;

  const CustomBtn({
    super.key,
    required this.text,
    this.onTap,
    this.loadingColor,
    this.color,
    this.child,
    this.txtColor,
    this.paddingWidth,
    this.icon,
    this.loading = false,
    this.btnWidth,
    this.txtFontSize,
    this.withPadding = true,
    this.image,
    this.onlyBorder = false,
    this.btnHeight,
    this.showTransparent = false,
    this.radius,
    this.horizontalPadding = 15.0,
    this.gradient,
    this.active = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (active) {
          onTap?.call();
        }
      },
      child: Padding(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: withPadding ? 24 : 0),
        child: Opacity(
          opacity: active ? 1 : .5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            height: btnHeight ?? 56,
            width: btnWidth,
            decoration: BoxDecoration(
              border: onlyBorder
                  ? Border.all(color: AppColors.SUB_HEADER, width: 2)
                  : null,
              borderRadius: BorderRadius.circular(radius ?? 10),
              color: onlyBorder
                  ? color
                  : showTransparent
                      ? AppColors.kSecondary
                      : loading
                          ? (color ?? AppColors.kPrimary).withOpacity(.6)
                          : color ?? AppColors.kPrimary,
              // gradient: color != null ? null : LinearGradient(colors: Styles.kButtonGradient),
            ),
            child: loading
                ? SpinKitThreeBounce(
                    color: loadingColor ?? AppColors.kWhite, size: 25)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (icon != null)
                        Icon(
                          icon,
                          color: txtColor,
                        ),
                      if (image != null) image!,
                      if (icon != null || image != null && text != '')
                        SizedBox(
                          width: paddingWidth ?? 14,
                        ),
                      child ??
                          Expanded(
                            child: Text(
                              text!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: txtColor ?? Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: txtFontSize ?? 14,
                              ),
                            ),
                          )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
