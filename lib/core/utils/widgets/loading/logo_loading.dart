import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../assets/app_svg.dart';

class LogoLoadingWidget extends StatelessWidget {
  const LogoLoadingWidget({
    super.key,
    this.height,
    this.width,
  });
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        AppSvg.logo,
        height: height ?? 100,
        width: width ?? 100,
      ),
    );
  }
}
