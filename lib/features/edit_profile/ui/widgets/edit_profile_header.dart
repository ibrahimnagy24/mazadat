import 'package:flutter/material.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/extensions/media_query_helper.dart';

class EditProfileHeader extends StatelessWidget {
  const EditProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQueryHelper.width,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customImageIconSVG(
            imageName: AppSvg.logo,
            height: 75.h,
            width: 105.w,
          ),
        ],
      ),
    );
  }
}
