import 'package:flutter/material.dart';

import '../../../../core/shared/widgets/custom_back_icon.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';

class EditProfileAppBar extends StatelessWidget {
  const EditProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.w,
      children: [
        const CustomBackIcon(),
        Expanded(
          child: Text(
            AppStrings.editProfileInfo.tr,
            style: AppTextStyles.displayMdBold,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
