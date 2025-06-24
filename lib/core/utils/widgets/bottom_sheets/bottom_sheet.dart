import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../theme/colors/styles.dart';
import '../../../navigation/custom_navigation.dart';

Future<dynamic> showAppBottomSheet({BuildContext? context, required Widget widget, Function()? onClose}) {
  return showMaterialModalBottomSheet(
      enableDrag: true,
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.transparent,
      context: CustomNavigator.navigatorState.currentContext!,
      expand: false,
      useRootNavigator: true,
      isDismissible: true,
      builder: (_) {
        return Padding(
          padding: MediaQuery.of(CustomNavigator.navigatorState.currentContext!).viewInsets,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: widget,
          ),
        );
      }).then((value) => onClose != null ? onClose() : () {});
}
