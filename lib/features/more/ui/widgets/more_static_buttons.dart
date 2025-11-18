import 'package:flutter/material.dart';

import '../../../../core/app_config/api_names.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/animated/grid_list_animator.dart';
import '../../../contact_us/data/params/contact_us_route_params.dart';
import '../../../faq/data/params/faq_route_params.dart';
import '../../../static_pages/data/params/static_page_params.dart';
import 'more_card.dart';

class MoreStaticButtons extends StatelessWidget {
  const MoreStaticButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return GridListAnimator(
      padding: EdgeInsets.symmetric(vertical: 18.h),
      data: [
        MoreCard(
          icon: AppSvg.customerService,
          title: AppStrings.contactUs.tr,
          onTap: () {
            CustomNavigator.push(
              Routes.CONTACT_US,
              extra: const ContactUsRouteParams(),
            );
          },
        ),
        MoreCard(
          icon: AppSvg.quiz,
          title: AppStrings.faqs.tr,
          // background: AppColors.borderSecondary.withValues(alpha: 0.5),
          // iconColor: const Color.fromRGBO(173, 156, 109, 1),
          onTap: () {
            CustomNavigator.push(Routes.FAQ, extra: const FaqRouteParams());
          },
        ),
        MoreCard(
          icon: AppSvg.terms,
          title: AppStrings.termsAndConditions.tr,
          onTap: () {
            CustomNavigator.push(
              Routes.STATIC_PAGE,
              extra: StaticPageParams(
                url: Endpoints.termsAndConditions,
                title: AppStrings.termsAndConditions.tr,
              ),
            );
          },
        ),
        MoreCard(
          icon: AppSvg.policy,
          title: AppStrings.privacyPolicy.tr,
          onTap: () {
            CustomNavigator.push(
              Routes.STATIC_PAGE,
              extra: StaticPageParams(
                url: Endpoints.privacyAndPolicy,
                title: AppStrings.privacyPolicy.tr,
              ),
            );
          },
        ),
      ],
      crossAxisCount: 2,
      aspectRatio: 1.0,
    );
  }
}
