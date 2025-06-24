import 'package:flutter/material.dart';

import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';

class OauthTitleText extends StatelessWidget {
  const OauthTitleText({
    super.key,
    this.fontSize,
    this.text,
  });
  final double? fontSize;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return MainText(
      text: text ?? 'AppStrings.loginWith.tr',
      style: AppTextStyles.balooBhaijaan2W500Size16KPrimary1000.copyWith(
        fontSize: fontSize ?? 16,
      ),
    );
  }
}
