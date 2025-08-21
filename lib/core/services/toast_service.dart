import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import '../theme/colors/styles.dart';
import '../theme/text_styles/text_styles.dart';

class ToastService {
  /// Initialize the toast service - call this in your main widget
  static void initialize(BuildContext context) {
    try {
      InteractiveToast.initializeOverlayState(Overlay.of(context));
    } catch (e) {
      debugPrint('ToastService Initialize Error: $e');
    }
  }

  static void showSuccess(String message, {BuildContext? context}) {
    try {
      InteractiveToast.slide(
        context: context,
        title: Text(
          message,
          style: AppTextStyles.textMdMedium.copyWith(
            color: Colors.white,
          ),
        ),
        trailing: const Icon(
          Icons.check_circle,
          color: Colors.white,
          size: 20,
        ),
        toastSetting: const SlidingToastSetting(
          animationDuration: Duration(milliseconds: 400),
          displayDuration: Duration(seconds: 3),
          toastAlignment: Alignment.topCenter,
          toastStartPosition: ToastPosition.top,
        ),
        toastStyle: ToastStyle(
          backgroundColor: Colors.green,
          boxShadow: [
            BoxShadow(
              color: Colors.green.withAlpha(51),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('ToastService Error: $e');
    }
  }

  static void showError(String message, {BuildContext? context}) {
    try {
      InteractiveToast.slide(
        context: context,
        title: Text(
          message,
          style: AppTextStyles.textMdMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.error_outline_rounded,
            color: Colors.white,
            size: 18,
          ),
        ),
        toastSetting: const SlidingToastSetting(
          animationDuration: Duration(milliseconds: 600),
          displayDuration: Duration(seconds: 4),
          toastAlignment: Alignment.topCenter,
          toastStartPosition: ToastPosition.top,
          progressBarHeight: 4,
        ),
        toastStyle: ToastStyle(
          backgroundColor: const Color(0xFFE53E3E),
          borderRadius: BorderRadius.circular(16),
          progressBarColor: Colors.white.withOpacity(0.8),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE53E3E).withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('ToastService Error: $e');
    }
  }

  static void showWarning(String message, {BuildContext? context}) {
    try {
      InteractiveToast.slide(
        context: context,
        title: Text(
          message,
          style: AppTextStyles.textMdMedium.copyWith(
            color: Colors.white,
          ),
        ),
        trailing: const Icon(
          Icons.warning,
          color: Colors.white,
          size: 20,
        ),
        toastSetting: const SlidingToastSetting(
          animationDuration: Duration(milliseconds: 400),
          displayDuration: Duration(seconds: 3),
          toastAlignment: Alignment.topCenter,
          toastStartPosition: ToastPosition.top,
        ),
        toastStyle: ToastStyle(
          backgroundColor: Colors.orange,
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withAlpha(51),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('ToastService Error: $e');
    }
  }

  static void showInfo(String message, {BuildContext? context}) {
    try {
      InteractiveToast.slide(
        context: context,
        title: Text(
          message,
          style: AppTextStyles.textMdMedium.copyWith(
            color: Colors.white,
          ),
        ),
        trailing: const Icon(
          Icons.info,
          color: Colors.white,
          size: 20,
        ),
        toastSetting: const SlidingToastSetting(
          animationDuration: Duration(milliseconds: 400),
          displayDuration: Duration(seconds: 3),
          toastAlignment: Alignment.topCenter,
          toastStartPosition: ToastPosition.top,
        ),
        toastStyle: ToastStyle(
          backgroundColor: AppColors.kPrimary,
          boxShadow: [
            BoxShadow(
              color: AppColors.kPrimary.withAlpha(51),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('ToastService Error: $e');
    }
  }

  /// Glassy toast with blur effect
  static void showGlassy(String message, {BuildContext? context}) {
    try {
      InteractiveToast.slide(
        context: context,
        title: Text(
          message,
          style: AppTextStyles.textMdMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.auto_awesome,
          color: Colors.white,
          size: 20,
        ),
        toastSetting: const SlidingToastSetting(
          animationDuration: Duration(milliseconds: 500),
          displayDuration: Duration(seconds: 3),
          toastAlignment: Alignment.topCenter,
          toastStartPosition: ToastPosition.top,
          progressBarHeight: 3,
        ),
        toastStyle: const ToastStyle(
          glassBlur: 8,
          backgroundColorOpacity: 0.2,
          backgroundColor: Colors.white,
          progressBarColor: Colors.white,
        ),
      );
    } catch (e) {
      debugPrint('ToastService Error: $e');
    }
  }

  /// Shows a glassy error toast with blur effect
  static void showGlassyError(String message, {BuildContext? context}) {
    try {
      InteractiveToast.slide(
        context: context,
        title: Text(
          message,
          style: AppTextStyles.textMdMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 20,
        ),
        toastSetting: const SlidingToastSetting(
          animationDuration: Duration(milliseconds: 500),
          displayDuration: Duration(seconds: 4),
          toastAlignment: Alignment.topCenter,
          toastStartPosition: ToastPosition.top,
          progressBarHeight: 3,
        ),
        toastStyle: const ToastStyle(
          glassBlur: 8,
          backgroundColorOpacity: 0.3,
          backgroundColor: Colors.red,
          progressBarColor: Colors.white,
        ),
      );
    } catch (e) {
      debugPrint('ToastService Error: $e');
    }
  }

  static void showCustom({
    required String message,
    required Color backgroundColor,
    required IconData icon,
    Color? textColor,
    Color? iconColor,
    Duration? duration,
    BuildContext? context,
    bool glassy = false,
  }) {
    try {
      InteractiveToast.slide(
        context: context,
        title: Text(
          message,
          style: AppTextStyles.textMdMedium.copyWith(
            color: textColor ?? Colors.white,
          ),
        ),
        trailing: Icon(
          icon,
          color: iconColor ?? Colors.white,
          size: 20,
        ),
        toastSetting: SlidingToastSetting(
          animationDuration: const Duration(milliseconds: 400),
          displayDuration: duration ?? const Duration(seconds: 3),
          toastAlignment: Alignment.topCenter,
          toastStartPosition: ToastPosition.top,
        ),
        toastStyle: ToastStyle(
          backgroundColor: backgroundColor,
          glassBlur: glassy ? 6 : 0,
          backgroundColorOpacity: glassy ? 0.3 : 1.0,
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withAlpha(51),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('ToastService Error: $e');
    }
  }

  /// Close all active toasts
  static void closeAll() {
    try {
      InteractiveToast.closeAllToast();
    } catch (e) {
      debugPrint('ToastService Error: $e');
    }
  }
}
