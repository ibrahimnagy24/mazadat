import 'package:flutter/material.dart';
import 'responsive_service.dart';

/// Flutter implementation of ResponsiveService
/// Replaces responsive_builder with internal responsive logic
class FlutterResponsiveImpl implements ResponsiveService {
  @override
  ScreenBreakpoint getScreenBreakpoint(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width <= ResponsiveBreakpoints.mobileMaxWidth) {
      return ScreenBreakpoint.mobile;
    } else if (width <= ResponsiveBreakpoints.tabletMaxWidth) {
      return ScreenBreakpoint.tablet;
    } else {
      return ScreenBreakpoint.desktop;
    }
  }

  @override
  bool isMobile(BuildContext context) {
    return getScreenBreakpoint(context) == ScreenBreakpoint.mobile;
  }

  @override
  bool isTablet(BuildContext context) {
    return getScreenBreakpoint(context) == ScreenBreakpoint.tablet;
  }

  @override
  bool isDesktop(BuildContext context) {
    return getScreenBreakpoint(context) == ScreenBreakpoint.desktop;
  }

  @override
  T getResponsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final breakpoint = getScreenBreakpoint(context);
    
    switch (breakpoint) {
      case ScreenBreakpoint.mobile:
        return mobile;
      case ScreenBreakpoint.tablet:
        return tablet ?? mobile;
      case ScreenBreakpoint.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }

  @override
  double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  @override
  double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  @override
  double getResponsiveFontSize(BuildContext context, double baseFontSize) {
    final breakpoint = getScreenBreakpoint(context);
    
    switch (breakpoint) {
      case ScreenBreakpoint.mobile:
        return baseFontSize;
      case ScreenBreakpoint.tablet:
        return baseFontSize * 1.1;
      case ScreenBreakpoint.desktop:
        return baseFontSize * 1.2;
    }
  }

  @override
  EdgeInsets getResponsivePadding(
    BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final value = getResponsiveValue(
      context,
      mobile: mobile ?? 16.0,
      tablet: tablet,
      desktop: desktop,
    );
    
    return EdgeInsets.all(value);
  }

  @override
  EdgeInsets getResponsiveMargin(
    BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final value = getResponsiveValue(
      context,
      mobile: mobile ?? 8.0,
      tablet: tablet,
      desktop: desktop,
    );
    
    return EdgeInsets.all(value);
  }
}
