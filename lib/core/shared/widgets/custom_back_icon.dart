import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../assets/app_svg.dart';
import '../../navigation/custom_navigation.dart';
import '../../theme/colors/styles.dart';
import '../../utils/extensions/extensions.dart';
import '../blocs/main_app_bloc.dart';
import 'custom_images.dart';

class CustomBackIcon extends StatelessWidget {
  const CustomBackIcon({
    super.key,
    this.radius = 24,
    this.onPressed,
    this.iconColor,
  });
  final double radius;
  final void Function()? onPressed;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: mainAppBloc.isArabic ? 0 : 2,
      child: customImageIconSVG(
          imageName: AppSvg.backArrow,
          width: 24.w,
          height: 24.w,
          color: iconColor??AppColors.HEADER,
          onTap: () => CustomNavigator.pop()),
    );
  }
}
