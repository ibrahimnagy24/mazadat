import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/widgets/misc/custom_screen_type_layout_widget.dart';
import '../cubit/navbar_layout_cubit.dart';
import '../cubit/navbar_layout_state.dart';
import 'custom_navbar_layout_mobile_screen.dart';

class CustomNavbarLayoutScreen extends StatelessWidget {
  const CustomNavbarLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavbarLayoutCubit>();
    return BlocBuilder<NavbarLayoutCubit, NavbarLayoutState>(
      buildWhen: (previous, current) =>
          previous.currentIndex != current.currentIndex,
      builder: (context, state) {
        return CustomScreenTypeLayoutWidget(
          mobilePortrait: (context) =>
              const CustomNavbarLayoutMobilePortraitDesignScreen(),
          mobileLandscape: (context) =>
              const CustomNavbarLayoutMobileLandscapeDesignScreen(
            iconHeight: 45,
            iconWidth: 45,
            unselectedItemHeight: 25,
            unselectedItemWidth: 25,
            selectedItemWidth: 50,
            selectedItemHeight: 50,
          ),
          tabletPortrait: (context) =>
              const CustomNavbarLayoutMobilePortraitDesignScreen(),
          tabletLandscape: (context) =>
              const CustomNavbarLayoutMobileLandscapeDesignScreen(
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
        );
      },
    );
  }
}
