import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets/app_images.dart';
import '../../../core/assets/app_svg.dart';
import '../../../core/theme/text_styles/text_styles.dart';

import '../../../core/utils/extensions/extensions.dart';
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
    return Stack(
      children: [
        Image.asset(
          AppImages.menShakeHand,
          width: MediaQuery.sizeOf(context).width,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 8,
              top: 27,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    MainText(
                      text: 'Mazadat',
                      style: AppTextStyles.exoW700SizeMediumWhite,
                    ),
                    8.sbW,
                    // SvgPicture.asset(
                    //   AppSvg.logo,
                    //   height: 18,
                    //   width: 18,
                    // )
                  ],
                ),
                16.sbH,
                MainText(
                  text: title ?? 'AppStrings.welcomeToTheWorldOfAuctions.tr',
                  style: AppTextStyles.headingLBold,
                  textAlign: TextAlign.start,
                ),
                12.sbH,
                MainText(
                  text: subtitle ??
                      'AppStrings.registerYourAccountAndStayCloseToTheStrongestAuctions.tr',
                  style: AppTextStyles.bodyXsReq,
                  textAlign: TextAlign.start,
                ),
                if (body != null) body!,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
