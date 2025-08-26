import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets/app_svg.dart';
import '../../../core/theme/text_styles/text_styles.dart';

import '../../../core/utils/extensions/media_query_helper.dart';
import '../../../core/utils/widgets/text/main_text.dart';

class AuthTitleImageBannerWidget extends StatelessWidget {
  const AuthTitleImageBannerWidget({
    super.key,
    this.title,
    this.subtitle,
    this.body,
    this.height = 220,
  });
  final String? title;
  final String? subtitle;
  final Widget? body;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQueryHelper.width,
      height: height,
      padding: const EdgeInsetsDirectional.only(
        start: 18,
        end: 18,
        top: 24,
        bottom: 24,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(64, 77, 38, 1),
            Color.fromRGBO(24, 28, 16, 1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppSvg.logo,
              height: 75,
              width: 105,
            ),
            if (title != null) ...[
              const SizedBox(height: 16),
              MainText(
                text: title ?? '',
                style: AppTextStyles.headingLBold,
                textAlign: TextAlign.start,
              ),
            ],
            if (subtitle != null) ...[
              const SizedBox(height: 12),
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
