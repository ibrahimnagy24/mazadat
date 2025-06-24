import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomNavbarItemWidget extends StatelessWidget {
  const CustomNavbarItemWidget({
    super.key,
    required this.activeIcon,
    required this.inActiveIcon,
    this.isSelected = false,
    this.selectedItemHeight,
    this.selectedItemWidth,
    this.unselectedItemHeight,
    this.unselectedItemWidth,
    this.iconHeight,
    this.iconWidth,
  });

  final String activeIcon;
  final String inActiveIcon;
  final bool isSelected;
  final double? selectedItemHeight;
  final double? selectedItemWidth;
  final double? unselectedItemHeight;
  final double? unselectedItemWidth;
  final double? iconHeight;
  final double? iconWidth;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isSelected
          ? selectedItemHeight ?? 48
          : unselectedItemHeight ?? 36,
      width:
          isSelected ? selectedItemWidth ?? 48 : unselectedItemWidth ?? 36,
      alignment: Alignment.center,
      child: SvgPicture.asset(
        isSelected ? activeIcon : inActiveIcon,
        height: iconHeight,
        width: iconWidth,
      ),
    );
  }
}
