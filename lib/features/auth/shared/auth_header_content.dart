import 'package:flutter/material.dart';

import '../../../core/theme/text_styles/text_styles.dart';
import '../../../core/utils/extensions/extensions.dart';
import '../../../core/utils/widgets/text/main_text.dart';

class AuthHeaderContent extends StatelessWidget {
  const AuthHeaderContent({super.key, this.title, this.subtitle});
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            MainText(
              text: title,
              style: AppTextStyles.displayMdBold,
              textAlign: TextAlign.start,
            ),
          if (subtitle != null) ...[
            12.sbH,
            MainText(
              text: subtitle,
              style: AppTextStyles.textLgRegular,
              textAlign: TextAlign.start,
            ),
          ]
        ],
      ),
    );
  }
}
