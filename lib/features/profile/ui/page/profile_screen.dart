import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../../core/utils/constant/app_constant.dart';
import 'profile_mobile_design.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      breakpoints: AppConstant.breakpoints,
      mobile: (_) => OrientationLayoutBuilder(
        portrait: (context) => const ProfileMobileDesign(),
        landscape: (context) => const ProfileMobileDesign(),
      ),
      tablet: (_) => OrientationLayoutBuilder(
        portrait: (context) => const ProfileMobileDesign(),
        landscape: (context) => const ProfileMobileDesign(),
      ),
    );
  }
}
