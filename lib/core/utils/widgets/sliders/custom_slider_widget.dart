import 'package:flutter/material.dart';

import '../../../theme/colors/styles.dart';

class CustomSliderWidget extends StatelessWidget {
  const CustomSliderWidget({
    super.key,
    required this.max,
    required this.min,
    required this.onChanged,
    required this.value,
    this.inactiveTrackColor = AppColors.LIGHT_GREY_BORDER,
    this.thumbColor = AppColors.kPrimary700,
    this.activeTrackColor = AppColors.kPrimary700,
  });
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final Color inactiveTrackColor;
  final Color thumbColor;
  final Color activeTrackColor;
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: activeTrackColor,
        inactiveTrackColor: inactiveTrackColor,
        trackHeight: 6,
        thumbColor: thumbColor,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 3,
          disabledThumbRadius: 3,
        ),
        overlayShape: SliderComponentShape.noThumb,
      ),
      child: Slider(
        value: value,
        onChanged: onChanged,
        min: min,
        max: max,
      ),
    );
  }
}
