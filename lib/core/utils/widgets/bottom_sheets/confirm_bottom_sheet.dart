import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../theme/text_styles/text_styles.dart' show AppTextStyles;
import '../../constant/app_strings.dart';
import '../../extensions/media_query_helper.dart';
import '../../../theme/colors/styles.dart';
import '../../../navigation/custom_navigation.dart';
import '../../extensions/extensions.dart';
import '../buttons/default_button.dart';

abstract class CustomBottomSheet {
  static show(
      {Function()? onConfirm,
      Function()? onCancel,
      String? label,
      String? buttonText,
      required Widget widget,
      double? height,
      Widget? child,
      Widget? labelWidget,
      bool? isLoading,
      bool withPadding = true,
      bool withCancel = true,
      Function()? onDismiss,
      Function()? onClose}) {
    return showMaterialModalBottomSheet(
      enableDrag: true,
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.transparent,
      context: CustomNavigator.navigatorState.currentContext!,
      expand: false,
      useRootNavigator: true,
      isDismissible: true,
      builder: (c) {
        return SafeArea(
          child: Padding(
            padding:
                MediaQuery.of(CustomNavigator.navigatorState.currentContext!)
                    .viewInsets,
            child: Container(
              constraints: BoxConstraints(
                  maxHeight: height ?? MediaQueryHelper.height * 0.7),
              width: MediaQueryHelper.width,
              decoration: BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60.w,
                    height: 4.h,
                    margin: EdgeInsets.only(
                      left: 18.w,
                      right: 18.w,
                      top: 8.h,
                      bottom: 18.h,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.kGeryText,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  labelWidget ?? const SizedBox(),
                  if (label != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(label, style: AppTextStyles.heading,maxLines: 1,
                              overflow: TextOverflow.ellipsis,)),
                          GestureDetector(
                            onTap: () {
                              CustomNavigator.pop();
                              onDismiss?.call();
                            },
                            child: const Icon(Icons.clear,
                                size: 24, color: AppColors.textDefault),
                          )
                        ],
                      ),
                    ),
                  // if (label != null)
                  //   Padding(
                  //     padding:
                  //         EdgeInsets.symmetric(vertical: 8.h, horizontal: 18.w),
                  //     child: const Divider(color: AppColors.border),
                  //   ),
                  Flexible(child: widget),
                  Visibility(
                    visible: child != null || onConfirm != null,
                    child: SafeArea(
                      top: false,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.w, vertical: 10.h),
                        child: child ??
                            Row(
                              children: [
                                Expanded(
                                  child: DefaultButton(
                                    text: buttonText ?? AppStrings.confirm.tr,
                                    isLoading: isLoading ?? false,
                                    onPressed: onConfirm,
                                  ),
                                ),
                                if (withCancel) SizedBox(width: 8.w),
                                if (withCancel)
                                  Expanded(
                                    child: DefaultButton(
                                      text: AppStrings.cancel.tr,
                                      backgroundColor: AppColors.kWhite,
                                      borderColor: AppColors.textPrimary,
                                      textColor: AppColors.textPrimary,
                                      onPressed: onCancel,
                                    ),
                                  ),
                              ],
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).then((value) => onClose?.call());
  }


}
