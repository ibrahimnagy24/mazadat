import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';

class RoundedRectangleRangeSliderValueIndicatorShape
    extends RangeSliderValueIndicatorShape {
  const RoundedRectangleRangeSliderValueIndicatorShape();

  static const double _borderRadius = 8;
  static const double _preferredHeight = 32;
  static const double _preferredWidth = 48;
  static const double _triangleHeight = 10;

  @override
  Size getPreferredSize(
    bool isEnabled,
    bool isDiscrete, {
    required TextPainter labelPainter,
    required double textScaleFactor,
  }) {
    return const Size(
      _preferredWidth,
      _preferredHeight + _triangleHeight,
    );
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isOnTop = false,
    required TextPainter labelPainter,
    double? textScaleFactor,
    Size? sizeWithOverflow,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    double? value,
    Thumb? thumb,
  }) {
    final Canvas canvas = context.canvas;
    final double scale = activationAnimation.value;
    final double textScaleFactorValue = textScaleFactor ?? 1.0;

    final double overallScale = scale * textScaleFactorValue;
    final double inverseTextScale = 1.0 / textScaleFactorValue;

    final double labelHalfWidth = labelPainter.width / 2.0;
    final double halfWidthNeeded = labelHalfWidth + 8;
    final double width = halfWidthNeeded > _preferredWidth / 2
        ? halfWidthNeeded * 2
        : _preferredWidth;
    const double height = _preferredHeight;
    const double halfHeight = height / 2;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(overallScale, overallScale);

    final Paint paint = Paint()
      ..color = sliderTheme.valueIndicatorColor ?? Colors.grey
      ..style = PaintingStyle.fill;

    // Create paddle shape with rounded corners
    final Path path = Path();

    // Start from bottom center (neck of paddle)
    path.moveTo(0, 0);

    // Draw neck
    path.lineTo(-4, -_triangleHeight);
    path.lineTo(4, -_triangleHeight);
    path.close();

    // Draw rounded rectangle body
    final RRect bodyRRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: const Offset(0, -_triangleHeight - halfHeight),
        width: width,
        height: height,
      ),
      const Radius.circular(_borderRadius),
    );

    canvas.drawPath(path, paint);
    canvas.drawRRect(bodyRRect, paint);

    // Draw text
    canvas.scale(inverseTextScale, inverseTextScale);
    labelPainter.paint(
      canvas,
      Offset(
        -labelPainter.width / 2.0,
        -_triangleHeight - halfHeight - labelPainter.height / 2.0,
      ),
    );

    canvas.restore();
  }
}

class SearchOpeningPriceFilter extends StatefulWidget {
  const SearchOpeningPriceFilter({super.key, this.initialValue, this.onTap});
  final RangeValues? initialValue;
  final Function(RangeValues)? onTap;

  @override
  State<SearchOpeningPriceFilter> createState() =>
      _SearchOpeningPriceFilterState();
}

class _SearchOpeningPriceFilterState extends State<SearchOpeningPriceFilter> {
  late RangeValues _currentRangeValues;
  static const double _maxValue = 1000000;

  @override
  void initState() {
    super.initState();
    _currentRangeValues = widget.initialValue ?? const RangeValues(0, 1000000);
  }

  @override
  void didUpdateWidget(SearchOpeningPriceFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update the range values when the initialValue prop changes
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        _currentRangeValues = widget.initialValue ?? const RangeValues(0, 1000000);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text(
            AppStrings.openingPrice.tr,
            style: AppTextStyles.textLgBold
                .copyWith(color: const Color.fromRGBO(46, 46, 46, 1)),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 8,
              activeTrackColor: const Color.fromRGBO(81, 94, 50, 1),
              inactiveTrackColor: const Color.fromRGBO(250, 250, 250, 1),
              thumbColor: const Color.fromRGBO(81, 94, 50, 1),
              overlayColor: const Color.fromRGBO(238, 239, 235, 1),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
              rangeValueIndicatorShape:
                  const RoundedRectangleRangeSliderValueIndicatorShape(),
              valueIndicatorColor: const Color.fromRGBO(238, 239, 235, 1),
              valueIndicatorTextStyle: AppTextStyles.bodyXsMed
                  .copyWith(color: const Color.fromRGBO(81, 94, 50, 1)),
              showValueIndicator: ShowValueIndicator.always,
            ),
            child: RangeSlider(
              values: _currentRangeValues,
              min: 0,
              max: _maxValue,
              divisions: 100,
              onChanged: (value) {
                setState(() {
                  _currentRangeValues = value;
                });
                widget.onTap?.call(value);
              },
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        '0',
                        //  _currentRangeValues.start.round().toString(),
                        style: AppTextStyles.textLgRegular.copyWith(
                            color: const Color.fromRGBO(162, 162, 162, 1)),
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset(
                      AppSvg.saudiArabiaSymbol,
                      color: const Color.fromRGBO(162, 162, 162, 1),
                      width: 14,
                      height: 14,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        '1000000',
                        // _currentRangeValues.end.round().toString(),
                        style: AppTextStyles.textLgRegular.copyWith(
                            color: const Color.fromRGBO(162, 162, 162, 1)),
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset(
                      AppSvg.saudiArabiaSymbol,
                      color: const Color.fromRGBO(162, 162, 162, 1),
                      width: 14,
                      height: 14,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
