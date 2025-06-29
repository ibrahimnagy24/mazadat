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
  });
  final double radius;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: mainAppBloc.isArabic ? 0 : 4,
      child: customImageIconSVG(
          imageName: AppSvg.backArrow,
          width: 24.w,
          height: 24.w,
          color: AppColors.HEADER,
          onTap: () => CustomNavigator.pop()),
    );
  }
}
