import 'package:flutter/material.dart';

import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/extensions/extensions.dart';


class DeleteAccountContent extends StatelessWidget {
  const DeleteAccountContent({super.key, this.title, this.subtitle});
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
            Text(
              title!,
              style: AppTextStyles.displayMdBold,
              textAlign: TextAlign.start,
            ),
          if (subtitle != null) ...[
            12.sbH,
            Text(
              subtitle!,
              style: AppTextStyles.textLgRegular,
              textAlign: TextAlign.start,
            ),
          ]
        ],
      ),
    );
  }
}
