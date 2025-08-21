import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/toast_service.dart';
import '../../../core/theme/colors/styles.dart';
import '../../../core/utils/extensions/extensions.dart';
import '../cubit/navbar_layout_cubit.dart';
import '../cubit/navbar_layout_state.dart';
import '../widgets/custom_navbar_widget.dart';

class CustomNavbarLayoutMobilePortraitDesignScreen extends StatefulWidget {
  const CustomNavbarLayoutMobilePortraitDesignScreen({super.key});

  @override
  State<CustomNavbarLayoutMobilePortraitDesignScreen> createState() =>
      _CustomNavbarLayoutMobilePortraitDesignScreenState();
}

class _CustomNavbarLayoutMobilePortraitDesignScreenState
    extends State<CustomNavbarLayoutMobilePortraitDesignScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NavbarLayoutCubit>().onPageInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavbarLayoutCubit>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<NavbarLayoutCubit, NavbarLayoutState>(
              buildWhen: (previous, current) =>
                  previous.currentIndex != current.currentIndex,
              builder: (context, state) {
                return PageView(
                  controller: cubit.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  reverse: true,
                  children: cubit.pages,
                );
              },
            ),
          ),
          const CustomNavbarWidget(),
        ],
      ),
    );
  }
}

class CustomNavbarLayoutMobileLandscapeDesignScreen extends StatefulWidget {
  const CustomNavbarLayoutMobileLandscapeDesignScreen({
    super.key,
    this.padding,
    this.selectedItemHeight = 80,
    this.selectedItemWidth = 80,
    this.unselectedItemHeight = 40,
    this.unselectedItemWidth = 40,
    this.iconHeight = 65,
    this.iconWidth = 65,
  });
  final EdgeInsetsGeometry? padding;
  final double? selectedItemHeight;
  final double? selectedItemWidth;
  final double? unselectedItemHeight;
  final double? unselectedItemWidth;
  final double? iconHeight;
  final double? iconWidth;

  @override
  State<CustomNavbarLayoutMobileLandscapeDesignScreen> createState() =>
      _CustomNavbarLayoutMobileLandscapeDesignScreenState();
}

class _CustomNavbarLayoutMobileLandscapeDesignScreenState
    extends State<CustomNavbarLayoutMobileLandscapeDesignScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NavbarLayoutCubit>().onPageInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavbarLayoutCubit>();
    return Container(
      color: AppColors.kWhite,
      padding: widget.padding,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: PageView(
                scrollDirection: Axis.vertical,
                controller: cubit.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: cubit.pages,
              ),
            ),
            20.sbW,
            BlocBuilder<NavbarLayoutCubit, NavbarLayoutState>(
              buildWhen: (previous, current) =>
                  previous.currentIndex != current.currentIndex,
              builder: (context, state) {
                return CustomNavbarWidget(
                  isPortraitView: false,
                  selectedItemHeight: widget.selectedItemHeight,
                  selectedItemWidth: widget.selectedItemWidth,
                  unselectedItemHeight: widget.unselectedItemHeight,
                  unselectedItemWidth: widget.unselectedItemWidth,
                  iconHeight: widget.iconHeight,
                  iconWidth: widget.iconWidth,
                  padding: const EdgeInsetsDirectional.only(top: 20),
                ).animate().moveX(begin: 250);
              },
            ),
          ],
        ),
      ),
    );
  }
}
