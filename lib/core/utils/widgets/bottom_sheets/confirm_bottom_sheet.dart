import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../buttons/custom_btn.dart';
import '../../extensions/media_query_helper.dart';
import '../../../theme/colors/styles.dart';
import '../../../navigation/custom_navigation.dart';
import '../../extensions/extensions.dart';

abstract class CustomBottomSheet {
  static show({
    Function? onConfirm,
    required String? label,
    required Widget? list,
    double? height,
    EdgeInsetsGeometry? padding,
    BuildContext? context,
  }) {
    showMaterialModalBottomSheet(
      context: context ?? CustomNavigator.context,
      backgroundColor: Colors.transparent,
      // isScrollControlled: true,
      // constraints: BoxConstraints(maxHeight: height ?? (MediaQueryHelper.height - 200)),
      builder: (_) {
        return Padding(
          padding: MediaQuery.of(CustomNavigator.context).viewInsets,
          child: Opacity(
            opacity: 1,
            child: Container(
              height: height ?? 240,
              width: MediaQueryHelper.width,
              decoration: const BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          padding ?? const EdgeInsets.fromLTRB(30, 0, 30, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(height: 24),
                          const SizedBox(height: 16),
                          Text(
                            label!,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 16),
                          Expanded(child: list!),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: onConfirm != null,
                    child: CustomBtn(
                      text: 'Submit'.tr,
                      paddingWidth: 0,
                      horizontalPadding: 0,
                      onTap: () {
                        onConfirm!();
                      },
                      btnHeight: 79,
                      radius: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
