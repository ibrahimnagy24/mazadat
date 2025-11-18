import 'package:flutter/material.dart';

import '../../../core/theme/text_styles/text_styles.dart';
import '../../../core/utils/widgets/text/main_text.dart';

class AuthHeaderContent extends StatelessWidget {
  const AuthHeaderContent({super.key, this.title, this.subtitle});
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          MainText(
            text: title,
            style: AppTextStyles.displayMdBold,
            textAlign: TextAlign.start,
          ),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          MainText(
            text: subtitle,
            style: AppTextStyles.textLgRegular
                .copyWith(color: const Color.fromRGBO(116, 116, 116, 1)),
            textAlign: TextAlign.start,
          ),
        ]
      ],
    );
  }
}
