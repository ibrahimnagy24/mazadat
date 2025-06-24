import 'package:flutter/material.dart';
import '../../theme/text_styles/text_styles.dart';
import '../../utils/widgets/text/main_text.dart';

class BarqTextWithFlashIconImageWidget extends StatelessWidget {
  const BarqTextWithFlashIconImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MainText(
      text: 'Mazadat',
      style:
          AppTextStyles.balooBhaijaan2W700Size14KGold2.copyWith(fontSize: 20),
    ); //SvgPicture.asset(AppSvg.barqTextWithFlashIcon);
  }
}
