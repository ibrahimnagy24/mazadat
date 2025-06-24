import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../assets/app_svg.dart';
import '../../theme/text_styles/text_styles.dart';
import '../../utils/widgets/text/main_text.dart' show MainText;

class PriceWidgetWithFlagWidget extends StatelessWidget {
  const PriceWidgetWithFlagWidget({
    super.key,
    this.price,
    this.text,
    this.priceStyle,
    this.colorFilter,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });

  final String? price;
  final String? text;
  final TextStyle? priceStyle;
  final ColorFilter? colorFilter;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        if (text != null)
          MainText(
            text: text,
            style: AppTextStyles.w500FontXXSkGeryText8,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: MainText(
            text: price ?? '0',
            style: priceStyle ?? AppTextStyles.bodyMBold,
          ),
        ),
        SvgPicture.asset(
          AppSvg.saudiArabiaSymbol,
          colorFilter: colorFilter,
        ),
      ],
    );
  }
}
