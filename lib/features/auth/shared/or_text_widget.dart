import 'package:flutter/material.dart';
import '../../../core/theme/colors/styles.dart';
import '../../../core/theme/text_styles/text_styles.dart';
import '../../../core/utils/constant/app_strings.dart';
import '../../../core/utils/extensions/extensions.dart';

class OrTextWidget extends StatelessWidget {
  const OrTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.border,
            height: 12,
          ),
        ),
        Text(
          '  ${AppStrings.or.tr}  ',
          style: AppTextStyles.textMdMedium,
        ),
        const Expanded(
          child: Divider(
            color: AppColors.border,
            height: 1,
          ),
        ),
      ],
    );
  }
}
