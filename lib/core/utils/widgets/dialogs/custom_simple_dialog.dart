import 'package:flutter/material.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../theme/colors/styles.dart';
import '../../extensions/extensions.dart';

class CustomSimpleDialog {
  static parentSimpleDialog(
      {required Widget customListWidget,
      double? radius,
      EdgeInsets? contentPadding,
      bool? isDismissible}) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: SafeArea(
                child: SimpleDialog(
                  insetPadding: contentPadding ?? EdgeInsets.zero,
                  alignment: Alignment.bottomCenter,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius ?? 24),
                  ),
                  elevation: 3,
                  contentPadding: EdgeInsets.all(24.w),
                  backgroundColor: AppColors.background,
                  children: [customListWidget],
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        barrierDismissible: isDismissible ?? true,
        barrierLabel: '',
        context: CustomNavigator.context,
        // ignore: missing_return
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }
}
