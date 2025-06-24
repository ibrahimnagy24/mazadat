import 'package:flutter/material.dart';

import '../../../core/theme/text_styles/text_styles.dart';

import '../../../core/utils/extensions/extensions.dart';
import '../../../core/utils/widgets/text/main_text.dart';

class AuthTitleBoldText extends StatelessWidget {
  const AuthTitleBoldText({
    super.key,
    this.fontSize,
    this.text,
  });
  final double? fontSize;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return MainText(
      text: text ?? 'AppStrings.welcomeBack.tr',
      style: AppTextStyles.balooBhaijaan2W700Size24Primary1000.copyWith(
        fontSize: fontSize ?? 24,
      ),
    );
  }
}
