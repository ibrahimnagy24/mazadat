import 'package:flutter/material.dart';
import '../../../../core/utils/widgets/misc/custom_screen_type_layout_widget.dart';
import 'profile_mobile_design.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreenTypeLayoutWidget(
      mobilePortrait: (context) => const ProfileMobileDesign(),
      mobileLandscape: (context) => const ProfileMobileDesign(),
    );
  }
}
