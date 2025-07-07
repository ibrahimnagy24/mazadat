import 'package:flutter/material.dart';

import '../../../../core/assets/app_images.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';

class EditProfileHeader extends StatelessWidget {
  const EditProfileHeader({super.key});

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
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          customImageIconSVG(
            imageName: AppSvg.logo,
            height: 75.h,
            width: 105.w,
          ),
        ]),
      ),
    );
  }
}
