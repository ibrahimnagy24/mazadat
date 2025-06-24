import 'package:flutter/material.dart';

import '../../../../../core/theme/text_styles/text_styles.dart';

import '../../../../../core/utils/widgets/text/main_text.dart';

class LoginTextWidget extends StatelessWidget {
  const LoginTextWidget({
    super.key,
    this.fontSize,
    this.text,
  });
  final double? fontSize;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MainText(
          text: text ?? 'AppStrings.login.tr',
          style: AppTextStyles.balooBhaijaan2W600Size16Primary1000.copyWith(
            fontSize: fontSize ?? 16,
          ),
        ),
      ],
    );
  }
}
