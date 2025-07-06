import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/assets/app_svg.dart';
import '../../../core/theme/colors/styles.dart';
import '../../../core/theme/radius/app_radius.dart';
import '../../../core/utils/constant/app_strings.dart';
import '../../../core/utils/extensions/extensions.dart';
import '../cubit/navbar_layout_cubit.dart';
import '../cubit/navbar_layout_state.dart';
import 'custom_navbar_item_widget.dart';

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
    return BlocBuilder<NavbarLayoutCubit, NavbarLayoutState>(
      builder: (context, state) {
        final cubit = context.read<NavbarLayoutCubit>();
        return Container(
            padding: EdgeInsetsDirectional.only(
                bottom: 4.h, start: AppRadius.rLg.w, end: AppRadius.rLg.w),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppRadius.rLg.w),
                topRight: Radius.circular(AppRadius.rLg.w),
              ),
              border: Border.all(color: AppColors.border),
              color: AppColors.navBarBackground,
            ),
            child: SafeArea(
              top: false,
              child: isPortraitView
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
            ));
      },
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
      Expanded(
        child: IconButton(
          onPressed: () => cubit.onItemTapped(2),
          padding: EdgeInsets.zero,
          icon: CustomNavbarItemWidget(
            icon: AppSvg.auction,
            label: AppStrings.myAuctions.tr,
            isSelected: cubit.currentIndex == 2,
            iconHeight: iconHeight ?? 24.h,
            iconWidth: iconWidth ?? 24.w,
            selectedItemHeight: selectedItemHeight,
            selectedItemWidth: selectedItemWidth,
            unselectedItemHeight: unselectedItemHeight,
            unselectedItemWidth: unselectedItemWidth,
          ),
        ),
      ),
      Expanded(
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => cubit.onItemTapped(1),
          icon: CustomNavbarItemWidget(
            icon: AppSvg.favourite,
            label: AppStrings.favourite.tr,
            isSelected: cubit.currentIndex == 1,
            iconHeight: iconHeight ?? 24.h,
            iconWidth: iconWidth ?? 24.w,
            selectedItemHeight: selectedItemHeight,
            selectedItemWidth: selectedItemWidth,
            unselectedItemHeight: unselectedItemHeight,
            unselectedItemWidth: unselectedItemWidth,
          ),
        ),
      ),
      Expanded(
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => cubit.onItemTapped(0),
          icon: CustomNavbarItemWidget(
            icon: AppSvg.logo,
            label: AppStrings.home.tr,
            isSelected: cubit.currentIndex == 0,
            iconHeight: iconHeight ?? 24.h,
            iconWidth: iconWidth ?? 34.w,
            selectedItemHeight: selectedItemHeight,
            selectedItemWidth: selectedItemWidth,
            unselectedItemHeight: unselectedItemHeight,
            unselectedItemWidth: unselectedItemWidth,
          ),
        ),
      ),
    ];
  }
}
