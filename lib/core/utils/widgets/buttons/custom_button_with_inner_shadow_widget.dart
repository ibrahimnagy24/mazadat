import 'package:flutter/material.dart';

import '../../../theme/colors/styles.dart';
import '../../../theme/text_styles/text_styles.dart';

import '../../extensions/extensions.dart';
import '../loading/adaptive_cirluer_progress.dart';

class CustomButtonWithInnerShadowWidget extends StatefulWidget {
  const CustomButtonWithInnerShadowWidget({
    super.key,
    this.height,
    this.width,
    this.borderRadiousValue,
    this.fontSize,
    this.text,
    this.onPressed,
    this.onPressedBoxShadow,
    this.boxShadow,
    this.color,
    this.textStyle,
    this.child,
    this.isLoading = false,
    this.isActive = true,
  });

  final double? height;
  final double? width;
  final double? borderRadiousValue;
  final double? fontSize;
  final String? text;
  final Function()? onPressed;
  final List<BoxShadow>? onPressedBoxShadow;
  final List<BoxShadow>? boxShadow;
  final Color? color;
  final TextStyle? textStyle;
  final Widget? child;
  final bool isLoading;
  final bool isActive;
  @override
  State<CustomButtonWithInnerShadowWidget> createState() =>
      _CustomButtonWithInnerShadowWidgetState();
}

class _CustomButtonWithInnerShadowWidgetState
    extends State<CustomButtonWithInnerShadowWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isLoading || !widget.isActive
          ? () {}
          : () {
              widget.onPressed?.call();
            },
      onTapDown: widget.isLoading || !widget.isActive
          ? (_) {}
          : (_) {
              setState(() {
                _isPressed = true;
              });
            },
      onTapUp: widget.isLoading || !widget.isActive
          ? (_) {}
          : (_) {
              setState(() {
                _isPressed = false;
              });
            },
      onTapCancel: widget.isLoading || !widget.isActive
          ? () {}
          : () {
              setState(() {
                _isPressed = false;
              });
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: widget.height ?? 50,
        width: widget.width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: widget.isActive
              ? widget.color ?? Colors.white
              : widget.color ?? AppColors.kOpacityGrey2,
          borderRadius: BorderRadius.circular(widget.borderRadiousValue ?? 24),
          boxShadow: !widget.isActive
              ? widget.boxShadow ?? []
              : _isPressed
                  ? widget.onPressedBoxShadow ??
                      [
                        BoxShadow(
                          color: const Color(0xffD0BDED).withOpacity(0.5),
                          offset: const Offset(1, 1),
                          blurRadius: 2,
                          spreadRadius: 1,
                        ),
                      ]
                  : widget.boxShadow ??
                      [
                        const BoxShadow(
                          color: Color(0xffD0BDED),
                          offset: Offset(-2, -2),
                          blurRadius: 1,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: const Color(0xffD0BDED).withOpacity(0.5),
                          offset: const Offset(2, 2),
                          blurRadius: 1,
                          spreadRadius: 1,
                        ),
                      ],
        ),
        child: widget.isLoading
            ? const Center(child: AdaptiveCircularProgress())
            : (widget.child ??
                Center(
                  child: Text(
                    widget.text ?? 'AppStrings.loginAsAGuest.tr',
                    style: widget.textStyle ??
                        AppTextStyles.balooBhaijaan2W500Size16KPrimary1000
                            .copyWith(
                          fontSize: widget.fontSize ?? 16,
                        ),
                    textAlign: TextAlign.center,
                  ),
                )),
      ),
    );
  }
}
