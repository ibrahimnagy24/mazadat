import 'package:flutter/material.dart';
import '../core/theme/colors/styles.dart';
import '../core/theme/text_styles/text_styles.dart';
import '../core/utils/extensions/extensions.dart';
import '../core/utils/widgets/buttons/custom_gradient_button_widget.dart';
import '../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../core/utils/widgets/text/main_text.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      backgroundColor: AppColors.kWhite,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Glass3DButtonWithColor(),
            30.sbH,
            const GradientBUTT(
              text: 'login',
            ),
            30.sbH,
            const CustomGradientButtonWidget(text: 'text')
          ],
        ),
      ),
    );
  }
}

class Glass3DButtonWithColor extends StatefulWidget {
  const Glass3DButtonWithColor({super.key});

  @override
  _Glass3DButtonWithColorState createState() => _Glass3DButtonWithColorState();
}

class _Glass3DButtonWithColorState extends State<Glass3DButtonWithColor> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        transform: Matrix4.identity()
          ..translate(0.0, _isPressed ? 1.0 : 0.0)
          ..scale(_isPressed ? 0.97 : 1.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: Container(
            color: AppColors.kPrimary700,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.kPrimary700,
                gradient: LinearGradient(
                  colors: _isPressed
                      ? [
                          AppColors.kPrimary700.withOpacity(.1),
                          Colors.white.withOpacity(0.1),
                          AppColors.kGold.withOpacity(.1),
                        ]
                      : [
                          Colors.white.withOpacity(0.2),
                          AppColors.kPrimary700.withOpacity(.2),
                          AppColors.kGold3.withOpacity(.2)
                        ],
                  begin: _isPressed ? Alignment.topCenter : Alignment.topLeft,
                  end: _isPressed
                      ? Alignment.bottomCenter
                      : Alignment.bottomRight,
                ),
                // border: Border.all(
                //   color: Colors.white.withOpacity(0.2),
                //   width: 1.5,
                // ),
              ),
              child: Center(
                child: MainText(
                  text: 'Click Me',
                  style: AppTextStyles.balooBhaijaan2W600Size14White
                      .copyWith(fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientBUTT extends StatefulWidget {
  const GradientBUTT({
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

  @override
  State<GradientBUTT> createState() => _GradientBUTTState();
}

class _GradientBUTTState extends State<GradientBUTT>
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

    return GestureDetector(
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
          ),
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(widget.borderRadiousValue ?? 24.0),
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius:
                    BorderRadius.circular(widget.borderRadiousValue ?? 24.0),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.1),
                    AppColors.kPrimary700,
                    AppColors.kGold3.withOpacity(.15),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
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
  }
}
