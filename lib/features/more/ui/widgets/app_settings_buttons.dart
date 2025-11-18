import 'package:flutter/material.dart';

import '../../../../core/app_config/api_names.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/utility.dart';
import '../../../static_pages/data/params/static_page_params.dart';
import 'more_button.dart';
import 'switch_language_button.dart';

class AppSettingsButtons extends StatelessWidget {
  const AppSettingsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.sbH,
        Text(
          AppStrings.appSettings.tr,
          style: AppTextStyles.textLgBold,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            borderRadius: BorderRadius.circular(AppRadius.rLg),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoreButton(
                title: AppStrings.language.tr,
                icon: AppSvg.language,
                action: const SwitchLanguageButton(),
              ),
              if (Utility.isUserLoggedIn())
                MoreButton(
                  title: AppStrings.notifications.tr,
                  icon: AppSvg.notification,
                  action: SizedBox(
                    height: 10,
                    child: Switch(
                      value: true,
                      inactiveThumbColor: AppColors.kWhite,
                      inactiveTrackColor: AppColors.border,
                      onChanged: (v) {
                        // onSwitch?.call();
                      },
                      trackOutlineColor:
                          WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                        return true ? AppColors.kPrimary : AppColors.border;
                      }),
                      trackOutlineWidth:
                          WidgetStateProperty.resolveWith<double?>(
                              (Set<WidgetState> states) {
                        return 1.0;
                      }),
                    ),
                  ),
                ),
              MoreButton(
                title: AppStrings.whoUs.tr,
                icon: AppSvg.info,
                onTap: () {
                  CustomNavigator.push(
                    Routes.STATIC_PAGE,
                    extra: StaticPageParams(
                      url: Endpoints.aboutUs,
                      title: AppStrings.privacyPolicy.tr,
                    ),
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
