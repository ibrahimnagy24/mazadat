import 'package:flutter/material.dart';
import '../../../../../core/utils/widgets/misc/custom_screen_type_layout_widget.dart';
import 'view_wallet_screen_mobile_design.dart';

class ViewWalletScreen extends StatelessWidget {
  const ViewWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreenTypeLayoutWidget(
      mobilePortrait: (context) => const ViewWalletScreenMobileDesign(),
      mobileLandscape: (context) => const ViewWalletScreenMobileDesign(),
    );
  }
}
