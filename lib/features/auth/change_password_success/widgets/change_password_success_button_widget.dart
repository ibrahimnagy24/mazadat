import 'package:flutter/material.dart';
import '../../../../../core/utils/widgets/buttons/custom_gradient_button_widget.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';

class ChangePasswordSuccessButtonWidget extends StatelessWidget {
  const ChangePasswordSuccessButtonWidget({
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
    return CustomGradientButtonWidget(
      text: 'AppStrings.backToLogin.tr',
      onPressed: () {
        CustomNavigator.push(
          Routes.LOGIN_SCREEN,
          clean: true,
        );
      },
      height: height,
      width: width,
      borderRadiousValue: borderRadiousValue,
      fontSize: fontSize,
    );
  }
}
