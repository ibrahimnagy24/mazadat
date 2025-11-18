import 'package:flutter/material.dart';
import '../../../assets/app_launchers.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import '../../extensions/media_query_helper.dart';


loadingDialog() {
  return showDialog(
    context: CustomNavigator.navigatorState.currentContext!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 18.w),
        insetPadding: EdgeInsets.symmetric(
            vertical: 30.w,
            horizontal: MediaQueryHelper.width * 0.2),
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20.0)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.asset(
            AppLaunchers.logo,
            color: AppColors.kPrimary,
            height: MediaQuery.of(context).size.width * .25,
            width: MediaQuery.of(context).size.width * .25,
          ),
          Padding(
            padding: EdgeInsets.only(
              top:18.w,
            ),
            child: Text(
              AppStrings.loading,
              style: AppTextStyles.textLgMedium,
            ),
          ),
        ]),
      );
    },
  );
}

