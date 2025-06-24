import 'package:flutter/material.dart';
import '../../../navigation/custom_navigation.dart';

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
              child: AlertDialog(
                insetPadding: contentPadding,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
                ),
                elevation: 3,
                contentPadding: const EdgeInsets.all(5),
                // children: [customListWidget],
                content: customListWidget,
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
