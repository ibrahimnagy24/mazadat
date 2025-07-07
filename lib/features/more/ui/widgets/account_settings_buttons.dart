import 'package:flutter/material.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/utility.dart';
import '../../../../core/utils/widgets/dialogs/custom_simple_dialog.dart';
import '../../../delete_account/ui/widgets/check_delete_account_dialog.dart';
import 'logout_confirmation_dialog.dart';
import 'more_button.dart';

class AccountSettingsButtons extends StatelessWidget {
  const AccountSettingsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.sbH,
        Text(
          AppStrings.accountSettings.tr,
          style: AppTextStyles.textLgBold,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(AppRadius.rLg)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Utility.isUserLoggedIn())
                MoreButton(
                  title: AppStrings.deleteAccount.tr,
                  icon: AppSvg.delete,
                  action: const SizedBox(),
                  onTap: () => CustomSimpleDialog.parentSimpleDialog(
                    isDismissible: false,
                    customListWidget: const CheckDeleteAccountDialog(),
                  ),
                ),
              MoreButton(
                title: Utility.isUserLoggedIn()
                    ? AppStrings.logout.tr
                    : AppStrings.login.tr,
                icon: Utility.isUserLoggedIn() ? AppSvg.logout : AppSvg.login,
                action: const SizedBox(),
                onTap: () => Utility.isUserLoggedIn()
                    ? CustomSimpleDialog.parentSimpleDialog(
                        isDismissible: false,
                        customListWidget: const LogoutConfirmationDialog(),
                      )
                    : CustomNavigator.push(Routes.LOGIN_SCREEN),
              ),
            ],
          ),
        )
      ],
    );
  }
}
