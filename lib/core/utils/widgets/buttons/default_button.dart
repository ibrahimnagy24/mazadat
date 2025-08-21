import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart' as vector;

import '../../../assets/app_svg.dart';
import '../../../shared/widgets/custom_images.dart';
import '../../../theme/text_styles/app_font_size_styles.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import '../loading/adaptive_circle_progress.dart';
import '../../../theme/colors/styles.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.child,
    this.onPressed,
    this.padding,
    this.text,
    this.borderRadiusValue = 8,
    this.fontSize,
    this.elevation,
    this.side,
    this.textColor,
    this.isLoading = false,
    this.fontWeight,
    this.height = 50,
    this.width,
    this.borderWidth,
    this.maxheight,
    this.maxwidth,
    this.textStyle,
    this.animationDuration,
    this.withSaudiRiyalSymbol = false,
    this.isInActive = false,
  });

  final void Function()? onPressed;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final String? text;
  final Widget? child;
  final double? borderRadiusValue;
  final double? fontSize;
  final double? elevation;
  final WidgetStateProperty<BorderSide?>? side;
  final Color? textColor;
  final bool isLoading;
  final bool isInActive;
  final FontWeight? fontWeight;
  final double? height;
  final double? width;
  final double? maxheight;
  final double? maxwidth;

  final double? borderWidth;
  final TextStyle? textStyle;
  final Duration? animationDuration;

  final bool withSaudiRiyalSymbol;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingAnimatedButton(
            onTap: () {},
            duration: animationDuration ?? const Duration(milliseconds: 1500),
            width: width ?? MediaQuery.of(context).size.width,
            height: height ?? 50,
            borderRadius: borderRadiusValue ?? 15,
            child: ElevatedButton(
              onPressed: isLoading ? () {} : onPressed ?? () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    backgroundColor ?? AppColors.kPrimary),
                side: side,
                minimumSize: WidgetStateProperty.all(Size(
                    width ?? MediaQuery.of(context).size.width, height ?? 45)),
                padding: WidgetStateProperty.all(
                    padding ?? const EdgeInsets.symmetric(horizontal: 5)),
                elevation: WidgetStateProperty.all(elevation ?? 1),
                visualDensity: const VisualDensity(
                  horizontal: .9,
                  vertical: .8,
                ),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: borderRadius ??
                        BorderRadius.circular(borderRadiusValue ?? 12),
                    side: BorderSide(
                      color:
                          borderColor ?? backgroundColor ?? AppColors.kPrimary,
                      width: borderWidth ?? 1,
                    ),
                  ),
                ),
              ),
              child: Text(
                AppStrings.loading.tr,
                style: textStyle ??
                    GoogleFonts.notoSans(
                      color: textColor ?? AppColors.kWhite,
                      fontSize: fontSize ?? AppFontSizes.fsM,
                      fontWeight: fontWeight ?? FontWeight.w700,
                    ),
              ),
            ),
          )
        : ElevatedButton(
            onPressed: isInActive || isLoading ? null : onPressed ?? () {},
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                isInActive
                    ? AppColors.kDisable
                    : backgroundColor ?? AppColors.kPrimary,
              ),
              side: side,
              minimumSize: WidgetStateProperty.all(Size(
                  width ?? MediaQuery.of(context).size.width, height ?? 50)),
              padding: WidgetStateProperty.all(
                  padding ?? const EdgeInsets.symmetric(horizontal: 5)),
              elevation:
                  WidgetStateProperty.all(isInActive ? 0 : elevation ?? 1),
              visualDensity: const VisualDensity(
                horizontal: .9,
                vertical: .8,
              ),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: borderRadius ??
                      BorderRadius.circular(borderRadiusValue ?? 12),
                  side: BorderSide(
                    color: isInActive
                        ? AppColors.kDisable
                        : borderColor ?? backgroundColor ?? AppColors.kPrimary,
                    width: borderWidth ?? 1,
                  ),
                ),
              ),
            ),
            child: isLoading
                ? const AdaptiveCircularProgress()
                : child ??
                    Row(
                      spacing: 8.w,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            text ?? 'LOGIN',
                            style: textStyle ??
                                GoogleFonts.notoSans(
                                  color: textColor ?? AppColors.kWhite,
                                  fontSize: fontSize ?? AppFontSizes.fsM,
                                  fontWeight: fontWeight ?? FontWeight.w700,
                                ),
                          ),
                        ),
                        if (withSaudiRiyalSymbol == true)
                          customImageIconSVG(
                              imageName: AppSvg.saudiArabiaSymbol,
                              width: fontSize ?? 16,
                              height: fontSize ?? 16,
                              color: textColor ?? AppColors.kWhite)
                      ],
                    ),
          );
  }
}

class LoadingAnimatedButton extends StatefulWidget {
  final Duration duration;
  final Widget child;
  final Function() onTap;
  final double width;
  final double height;

  final Color color;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;

  const LoadingAnimatedButton({
    super.key,
    required this.child,
    required this.onTap,
    this.width = 200,
    this.height = 50,
    this.color = AppColors.kSecondary,
    this.borderColor = Colors.white,
    this.borderRadius = 24.0,
    this.borderWidth = 3.0,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<LoadingAnimatedButton> createState() => _LoadingAnimatedButtonState();
}

class _LoadingAnimatedButtonState extends State<LoadingAnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      splashColor: widget.color,
      child: CustomPaint(
        painter: LoadingPainter(
          animation: _animationController,
          borderColor: widget.borderColor,
          borderRadius: widget.borderRadius,
          borderWidth: widget.borderWidth,
          color: widget.color,
        ),
        child: Container(
          width: widget.width,
          height: widget.height,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(5.5),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class LoadingPainter extends CustomPainter {
  final Animation animation;
  final Color color;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;

  LoadingPainter(
      {required this.animation,
      this.color = Colors.orange,
      this.borderColor = Colors.white,
      this.borderRadius = 24.0,
      this.borderWidth = 3.0})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = SweepGradient(
              colors: [
                color.withOpacity(.25),
                color,
              ],
              startAngle: 0.0,
              endAngle: vector.radians(180),
              stops: const [.75, 1.0],
              transform:
                  GradientRotation(vector.radians(360.0 * animation.value)))
          .createShader(rect);

    final path = Path.combine(
        PathOperation.xor,
        Path()
          ..addRRect(
              RRect.fromRectAndRadius(rect, Radius.circular(borderRadius))),
        Path()
          ..addRRect(RRect.fromRectAndRadius(
              rect.deflate(4.5), Radius.circular(borderRadius))));
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            rect.deflate(1.5), Radius.circular(borderRadius)),
        Paint()
          ..color = borderColor
          ..strokeWidth = borderWidth
          ..style = PaintingStyle.stroke);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
