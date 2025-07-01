import 'package:flutter/material.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/extensions/extensions.dart';

class FavouriteButton extends StatelessWidget {
  const FavouriteButton(
      {super.key,
      required this.id,
      this.isFav = false,
      this.withBackGround = true});
  final int? id;
  final bool isFav;

  final bool withBackGround;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: withBackGround ? EdgeInsets.all(11.w) : EdgeInsets.zero,
      decoration: withBackGround
          ? BoxDecoration(
              color: AppColors.backgroundBody,
              shape: BoxShape.circle,
              boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, -1),
                      blurRadius: 8,
                      spreadRadius: 0,
                      color: Colors.white.withValues(alpha: 0.2))
                ])
          : null,
      child: customImageIconSVG(
        imageName: isFav ? AppSvg.fillFav : AppSvg.fav,
        width: 18.w,
        height: 18.w,
      ),
    );
  }
}
