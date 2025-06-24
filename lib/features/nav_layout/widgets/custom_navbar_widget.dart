import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/colors/styles.dart';
import '../cubit/navbar_layout_cubit.dart';
import '../cubit/navbar_layout_state.dart';

class CustomNavbarWidget extends StatelessWidget {
  const CustomNavbarWidget({
    super.key,
    this.isPortraitView = true,
    this.selectedItemHeight,
    this.selectedItemWidth,
    this.unselectedItemHeight,
    this.unselectedItemWidth,
    this.iconHeight,
    this.iconWidth,
    this.padding,
  });
  final bool isPortraitView;
  final double? selectedItemHeight;
  final double? selectedItemWidth;
  final double? unselectedItemHeight;
  final double? unselectedItemWidth;
  final double? iconHeight;
  final double? iconWidth;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.kWhite,
      child: BlocBuilder<NavbarLayoutCubit, NavbarLayoutState>(
        builder: (context, state) {
          final cubit = context.read<NavbarLayoutCubit>();
          return Padding(
            padding: padding ??
                const EdgeInsetsDirectional.only(
                    bottom: 24, start: 24, end: 24),
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: AppColors.kOpacityGrey),
                  color: AppColors.kWhite,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.kWhite,
                      spreadRadius: .1,
                      blurRadius: 1,
                      offset: Offset(0, 4),
                    ),
                    BoxShadow(
                      color: AppColors.kWhite,
                      spreadRadius: .1,
                      blurRadius: 1,
                      offset: Offset(0, -4),
                    ),
                    BoxShadow(
                      color: AppColors.kWhite,
                      spreadRadius: .1,
                      blurRadius: 1,
                      offset: Offset(4, 0),
                      blurStyle: BlurStyle.outer,
                    ),
                    BoxShadow(
                      color: AppColors.kWhite,
                      spreadRadius: .1,
                      blurRadius: 1,
                      offset: Offset(-4, 0),
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
                height: isPortraitView ? 60 : null,
                child: isPortraitView
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: children(
                          cubit,
                          iconHeight: iconHeight,
                          iconWidth: iconWidth,
                          selectedItemHeight: selectedItemHeight,
                          selectedItemWidth: selectedItemWidth,
                          unselectedItemHeight: unselectedItemHeight,
                          unselectedItemWidth: unselectedItemWidth,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: children(
                          cubit,
                          iconHeight: iconHeight,
                          iconWidth: iconWidth,
                          selectedItemHeight: selectedItemHeight,
                          selectedItemWidth: selectedItemWidth,
                          unselectedItemHeight: unselectedItemHeight,
                          unselectedItemWidth: unselectedItemWidth,
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> children(
    NavbarLayoutCubit cubit, {
    final double? selectedItemHeight,
    final double? selectedItemWidth,
    final double? unselectedItemHeight,
    final double? unselectedItemWidth,
    final double? iconHeight,
    final double? iconWidth,
  }) {
    return [
      // IconButton(
      //   onPressed: () => cubit.onItemTapped(2),
      //   icon: CustomNavbarItemWidget(
      //     activeIcon: AppSvg.moreIconWithBackground,
      //     inActiveIcon: AppSvg.moreIcon,
      //     isSelected: cubit.currentIndex == 2,
      //     iconHeight: iconHeight,
      //     iconWidth: iconWidth,
      //     selectedItemHeight: selectedItemHeight,
      //     selectedItemWidth: selectedItemWidth,
      //     unselectedItemHeight: unselectedItemHeight,
      //     unselectedItemWidth: unselectedItemWidth,
      //   ),
      // ),
      // IconButton(
      //   onPressed: () => cubit.onItemTapped(1),
      //   icon: CustomNavbarItemWidget(
      //     activeIcon: AppSvg.homeIconWithBackground,
      //     inActiveIcon: AppSvg.homeIcon,
      //     isSelected: cubit.currentIndex == 1,
      //     iconHeight: iconHeight,
      //     iconWidth: iconWidth,
      //     selectedItemHeight: selectedItemHeight,
      //     selectedItemWidth: selectedItemWidth,
      //     unselectedItemHeight: unselectedItemHeight,
      //     unselectedItemWidth: unselectedItemWidth,
      //   ),
      // ),
      // IconButton(
      //   onPressed: () => cubit.onItemTapped(0),
      //   icon: CustomNavbarItemWidget(
      //     activeIcon: AppSvg.yourGameIconWithBackground,
      //     inActiveIcon: AppSvg.yourGameIcon,
      //     isSelected: cubit.currentIndex == 0,
      //     iconHeight: iconHeight,
      //     iconWidth: iconWidth,
      //     selectedItemHeight: selectedItemHeight,
      //     selectedItemWidth: selectedItemWidth,
      //     unselectedItemHeight: unselectedItemHeight,
      //     unselectedItemWidth: unselectedItemWidth,
      //   ),
      // ),
    ];
  }
}

class CustomNavbarItemData {
  final String activeIcon;
  final String inActiveIcon;

  CustomNavbarItemData({
    required this.activeIcon,
    required this.inActiveIcon,
  });
}
