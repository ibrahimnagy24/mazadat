import 'package:flutter/material.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/text_styles/text_styles.dart';

import 'default_button.dart';

class CustomGradientButtonWidget extends StatefulWidget {
  const CustomGradientButtonWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.height,
    this.width,
    this.borderRadiousValue,
    this.fontSize,
    this.isLoading = false,
    this.borderColor,
    this.borderWidth,
    this.animationBorderRadious = 24,
    this.animationDuration,
    this.isActive = true,
    this.loadingText,
    this.loadingTextStyle,
    this.loadingOnTap,
    this.textStyle,
    this.child,
  });
  final String text;
  final void Function()? onPressed;
  final double? height;
  final double? width;
  final double? borderRadiousValue;
  final double? fontSize;
  final bool isLoading;
  final Color? borderColor;
  final double? borderWidth;
  final double? animationBorderRadious;
  final Duration? animationDuration;
  final bool isActive;
  final String? loadingText;
  final TextStyle? loadingTextStyle;
  final dynamic Function()? loadingOnTap;
  final TextStyle? textStyle;
  final Widget? child;
  @override
  State<CustomGradientButtonWidget> createState() =>
      _CustomGradientButtonWidgetState();
}

class _CustomGradientButtonWidgetState extends State<CustomGradientButtonWidget>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  late AnimationController _controller;
  late Animation<double> _shadowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _shadowAnimation = Tween<double>(begin: 5.0, end: 10.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward(); // Trigger shadow animation
    setState(() {
      _scale = 0.95; // Scale down for 3D effect on tap
    });
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse(); // Reverse shadow animation
    setState(() {
      _scale = 1.0; // Reset scale
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xff4C2588);

    if (!widget.isActive) {
      return GestureDetector(
        onTap: null, // Disables the tap functionality
        child: Transform.scale(
          scale: 1.0, // Keeps the scale static
          child: Container(
            height: widget.height ?? 50.0,
            width: widget.width ?? double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(widget.borderRadiousValue ?? 24.0),
              color: AppColors.kOpacityGrey2, // Inactive background color
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.1), // Subtle shadow for inactive state
                  spreadRadius: 0.5,
                  blurRadius: 3,
                  offset: const Offset(0, 2), // Slight offset for depth
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(widget.borderRadiousValue ?? 24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors
                      .kOpacityGrey2, // Inner container with inactive color
                  borderRadius:
                      BorderRadius.circular(widget.borderRadiousValue ?? 24.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: widget.fontSize ?? 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.6), // Dimmed text color
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return widget.isLoading
        ? LoadingAnimatedButton(
            onTap: widget.loadingOnTap ?? () {},
            duration:
                widget.animationDuration ?? const Duration(milliseconds: 1500),
            width: widget.width ?? MediaQuery.of(context).size.width,
            height: widget.height ?? 50.5,
            borderRadius: widget.animationBorderRadious ?? 24,
            child: ElevatedButton(
              onPressed: widget.isLoading
                  ? widget.loadingOnTap ?? () {}
                  : widget.onPressed ?? () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(backgroundColor),
                minimumSize: WidgetStateProperty.all(Size(
                    widget.width ?? MediaQuery.of(context).size.width,
                    widget.height ?? 45)),
                padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 5)),
                elevation: WidgetStateProperty.all(1),
                visualDensity: const VisualDensity(
                  horizontal: .9,
                  vertical: .8,
                ),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        widget.animationBorderRadious ?? 24),
                    side: BorderSide(
                      color: widget.borderColor ?? backgroundColor,
                      width: widget.borderWidth ?? 1,
                    ),
                  ),
                ),
              ),
              child: widget.child ??
                  Text(
                    widget.loadingText ?? 'AppStrings.loading.tr',
                    style: widget.loadingTextStyle ??
                        AppTextStyles.balooBhaijaan2W400Size12White
                            .copyWith(fontSize: 12),
                  ),
            ),
          )
        : GestureDetector(
            onTap: widget.onPressed,
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: () {
              _controller.reverse();
              setState(() {
                _scale = 1.0;
              });
            },
            child: Transform.scale(
              scale: _scale,
              child: Container(
                height: widget.height ?? 55.0,
                width: widget.width ?? double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadiousValue ?? 24.0),
                  color: backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadiousValue ?? 24.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff4C2588),
                      borderRadius: BorderRadius.circular(
                          widget.borderRadiousValue ?? 24.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(0.6),
                          blurRadius: _shadowAnimation.value,
                          spreadRadius: -3,
                          offset: const Offset(5, 0),
                        ),
                        BoxShadow(
                          color: Colors.amber.withOpacity(0.3),
                          blurRadius: _shadowAnimation.value * 2,
                          spreadRadius: -3,
                          offset: const Offset(-5, 0),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: _shadowAnimation.value * 1.5,
                          spreadRadius: -3,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.text,
                      style: widget.textStyle ??
                          TextStyle(
                            fontSize: widget.fontSize ?? 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          );

    // return GestureDetector(
    //   onTap: onPressed,
    //   child: Container(
    //     height: height ?? 50.h,
    //     width: width ?? double.infinity,
    //     alignment: AlignmentDirectional.center,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(borderRadiousValue ?? 24.r),
    //       color: AppColors.kPrimary700,
    //     ),
    //     child: MainText(
    //       text: text,
    //       style: AppTextStyles.balooBhaijaan2W600Size16White.copyWith(
    //         fontSize: fontSize ?? 16.sp,
    //       ),
    //       maxLines: 1,
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    // );
    // return DefaultButton();
    ///
    // return GlassButton(
    //   onPressed: widget.onPressed ?? () {},
    //   blur: 3,
    //   borderRadius: BorderRadius.circular(24.r),
    //   border: 0,
    //   child: Container(
    //     height: 50.h,
    //     width: double.infinity,
    //     alignment: AlignmentDirectional.center,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(24.r),
    //       // color: AppColors.kPrimary700.withValues(alpha: .9),
    //       gradient: LinearGradient(
    //         colors: [
    //           AppColors.kPrimary700.withValues(alpha: 1),
    //           AppColors.kPrimary700.withValues(alpha: 1),
    //           AppColors.kPrimary700.withValues(alpha: .8),
    //           AppColors.kPrimary700.withValues(alpha: .8),
    //           AppColors.kPrimary700.withValues(alpha: .8),
    //           AppColors.kPrimary700.withValues(alpha: 1),
    //           AppColors.kPrimary700.withValues(alpha: 1),
    //           AppColors.kPrimary700.withValues(alpha: 1),
    //         ],
    //         stops: const [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 1],
    //       ),
    //     ),
    //     padding: EdgeInsets.zero,
    //     margin: EdgeInsets.zero,
    //     child: MainText(
    //       text: widget.text,
    //       style: AppTextStyles.balooBhaijaan2W600Size16White,
    //       maxLines: 1,
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    // );
    ///

    //   child: Center(
    //     child: MainText(
    //       text: text,
    //       style: AppTextStyles.balooBhaijaan2W600Size16White,
    //       maxLines: 1,
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    // ),
    // );
  }
}
