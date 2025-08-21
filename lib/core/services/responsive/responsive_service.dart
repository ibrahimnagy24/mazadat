import 'package:flutter/material.dart';

/// Abstract responsive service to replace responsive_builder dependency
/// This provides a clean interface for responsive design without vendor lock-in
abstract class ResponsiveService {
  /// Get screen breakpoint type
  ScreenBreakpoint getScreenBreakpoint(BuildContext context);
  
  /// Check if screen is mobile
  bool isMobile(BuildContext context);
  
  /// Check if screen is tablet
  bool isTablet(BuildContext context);
  
  /// Check if screen is desktop
  bool isDesktop(BuildContext context);
  
  /// Get responsive value based on screen size
  T getResponsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  });
  
  /// Get screen width
  double getScreenWidth(BuildContext context);
  
  /// Get screen height
  double getScreenHeight(BuildContext context);
  
  /// Get responsive font size
  double getResponsiveFontSize(BuildContext context, double baseFontSize);
  
  /// Get responsive padding
  EdgeInsets getResponsivePadding(
    BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  });
  
  /// Get responsive margin
  EdgeInsets getResponsiveMargin(
    BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  });
}

enum ScreenBreakpoint {
  mobile,
  tablet,
  desktop,
}

class ResponsiveBreakpoints {
  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 1024;
  static const double desktopMinWidth = 1025;
}

/// Extension methods for responsive design
extension ResponsiveExtensions on num {
  /// Convert to responsive width
  double w(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (this * screenWidth) / 375; // Base width 375 (iPhone design)
  }
  
  /// Convert to responsive height
  double h(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return (this * screenHeight) / 812; // Base height 812 (iPhone design)
  }
  
  /// Convert to responsive font size
  double sp(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (this * screenWidth) / 375;
  }
  
  /// Convert to responsive radius
  double r(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (this * screenWidth) / 375;
  }
}
