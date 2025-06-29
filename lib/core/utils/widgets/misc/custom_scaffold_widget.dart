import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../features/check_from_internet/ui/pages/check_from_internet_connection_screen.dart';
import '../../../theme/colors/styles.dart';

class CustomScaffoldWidget extends StatelessWidget {
  const CustomScaffoldWidget({
    super.key,
    required this.child,
    this.appbar,
    this.floatingActionButton,
    this.backgroundColor = AppColors.background,
    this.resizeToAvoidBottomInset,
    this.needAppbar = true,
    this.appbarTitle,
    this.appbarLeading,
    this.appbarHeight,
    this.centerAppbarTitle,
  });
  final Widget child;
  final PreferredSizeWidget? appbar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool needAppbar;
  final Widget? appbarTitle;
  final Widget? appbarLeading;
  final double? appbarHeight;
  final bool? centerAppbarTitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: needAppbar
          ? (appbar ??
              PreferredSize(
                preferredSize: Size.fromHeight(appbarHeight ?? 0),
                child: AppBar(
                  centerTitle: centerAppbarTitle,
                  backgroundColor: AppColors.kWhite,
                  elevation: 0,
                  systemOverlayStyle: backgroundColor == AppColors.background
                      ? const SystemUiOverlayStyle(
                          statusBarColor: AppColors.background,
                          statusBarIconBrightness: Brightness.dark,
                          systemNavigationBarColor: AppColors.background,
                          systemNavigationBarIconBrightness: Brightness.dark,
                        )
                      : SystemUiOverlayStyle.dark,
                  title: appbarTitle,
                  leading: appbarLeading,
                ),
              ))
          : null,
      body: Stack(
        children: [
          child,
          const SafeArea(child: CheckFromInternetConnectionWidget()),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
