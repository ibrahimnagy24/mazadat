import 'package:flutter/material.dart';

import '../../../core/assets/app_images.dart';
import '../../../core/assets/app_svg.dart';
import '../../../core/shared/widgets/custom_images.dart';
import '../../../core/theme/text_styles/text_styles.dart';

import '../../../core/utils/extensions/extensions.dart';
import '../../../core/utils/extensions/media_query_helper.dart';
import '../../../core/utils/widgets/text/main_text.dart';

class AuthTitleImageBannerWidget extends StatelessWidget {
  const AuthTitleImageBannerWidget({
    super.key,
    this.title,
    this.subtitle,
    this.body,
  });
  final String? title;
  final String? subtitle;
  final Widget? body;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQueryHelper.width,
      padding: EdgeInsetsDirectional.only(
        start: 18.w,
        end: 18.w,
        top: 24.w,
        bottom: 24.w,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              AppImages.authHeaderBk,
            ),
            fit: BoxFit.cover),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customImageIconSVG(
              imageName: AppSvg.logo,
              height: 75.h,
              width: 105.w,
            ),
            if (title != null) ...[
              16.sbH,
              MainText(
                text: title ?? '',
                style: AppTextStyles.headingLBold,
                textAlign: TextAlign.start,
              ),
            ],
            if (subtitle != null) ...[
              12.sbH,
              MainText(
                text: subtitle ?? '',
                style: AppTextStyles.bodyXsReq,
                textAlign: TextAlign.start,
              ),
            ],
            if (body != null) body!,
          ],
        ),
      ),
    );
  }
}
