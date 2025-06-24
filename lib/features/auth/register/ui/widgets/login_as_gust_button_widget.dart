import 'package:flutter/material.dart';
import '../../../visitor/ui/visitor_button_widget.dart';

class LoginAsGustButtonWidget extends StatelessWidget {
  const LoginAsGustButtonWidget({
    super.key,
    this.height,
    this.width,
    this.borderRadiousValue,
    this.fontSize,
  });
  final double? height;
  final double? width;
  final double? borderRadiousValue;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: VisitorButtonWidget(),
      // CustomButtonWithInnerShadowWidget(
      //   text: AppStrings.loginAsAGuest.tr,
      //   height: height ?? 55,
      //   width: width ?? MediaQuery.of(context).size.width,
      //   borderRadiousValue: borderRadiousValue ?? 24.r,
      //   fontSize: fontSize ?? 14,
      //   onPressed: () async {
      //     FocusScope.of(context).unfocus();
      //     // CustomNavigator.push(Routes.VISITOR_LOGIN_SCREEN);
      //   },
      // ),
    );
  }
}
