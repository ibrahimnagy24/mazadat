import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/theme/colors/styles.dart';
import '../../../shared/blocs/main_app_bloc.dart';
import '../../../theme/radiuos/app_radiuos.dart';
import '../../../theme/text_styles/text_styles.dart';

class DefaultPinCodeTextFieldWidget extends StatelessWidget {
  const DefaultPinCodeTextFieldWidget({
    super.key,
    this.onSave,
    this.onChanged,
    this.controller,
    this.onCompleted,
    this.onSubmitted,
    this.enabled = true,
    this.readOnly = false,
    //default 24
    this.fontSize,
    //default 14
    this.hintFontSize,
    //default 24
    this.borderRadious,
    this.fieldHeight,
    this.fieldWidth,
  });

  final void Function(String?)? onSave;
  final void Function(String)? onChanged;
  final void Function(String)? onCompleted;
  final void Function(String)? onSubmitted;
  final TextEditingController? controller;
  final bool enabled;
  final bool readOnly;
  final double? fontSize;
  final double? hintFontSize;
  final double? borderRadious;
  final double? fieldHeight;
  final double? fieldWidth;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 4,
      obscureText: false,
      animationType: AnimationType.fade,
      autoDisposeControllers: true,
      hapticFeedbackTypes: HapticFeedbackTypes.light,
      useHapticFeedback: true,
      cursorColor: AppColors.kGeryText6,
      backgroundColor: Colors.white,
      enablePinAutofill: true,
      autoDismissKeyboard: true,
      enabled: enabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      hintStyle: AppTextStyles.bodySReq.copyWith(fontSize: hintFontSize ?? 14),
      textStyle: AppTextStyles.bodySReq
          .copyWith(fontSize: fontSize, color: AppColors.kPrimary900),
      controller: TextEditingController(text: controller?.text ?? ''),
      onSaved: onSave,
      onCompleted: onCompleted,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      readOnly: readOnly,
      enableActiveFill: true,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(borderRadious ?? AppRadiuos.rS),
        fieldOuterPadding: const EdgeInsets.all(0),
        fieldHeight: fieldHeight ?? 60,
        fieldWidth: fieldWidth ?? 60,
        borderWidth: 1,
        activeBorderWidth: 1,
        inactiveBorderWidth: 1,
        selectedBorderWidth: 2,
        inactiveColor: AppColors.kOpacityGrey,
        inactiveFillColor: Colors.white,
        activeColor: AppColors.kOpacityGrey,
        selectedColor: AppColors.kPrimary300,
        activeFillColor: Colors.white,
        selectedFillColor: Colors.white.withOpacity(.5),
      ),
      errorTextDirection:
          mainAppBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
      errorTextMargin: const EdgeInsets.only(left: 20, right: 20),
      errorTextSpace: 25,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      animationDuration: const Duration(milliseconds: 300),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      appContext: context,
      validator: (value) =>
          value!.isEmpty ? 'AppStrings.thisFieldIsRequired.tr' : null,
    );
  }
}
