import 'package:flutter/widgets.dart';

import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';

import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';

class DontHaveAccountWidget extends StatelessWidget {
  const DontHaveAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainText(
            text: AppStrings.donthaveanaccount.tr,
            style: AppTextStyles.textMdRegular
                .copyWith(color: const Color.fromRGBO(116, 116, 116, 1)),
          ),
          const SizedBox(width: 5),
          MainText(
            text: AppStrings.createANewAccount.tr,
            style: AppTextStyles.textMdBold
                .copyWith(color: AppColors.textPrimaryColor),
            onTap: () {
              CustomNavigator.push(Routes.REGISTER_SCREEN);
            },
          ),
        ],
      ),
    );
  }
}
