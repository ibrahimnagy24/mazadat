import 'package:flutter/material.dart';

import '../../../../../core/utils/widgets/form_fields/default_pin_code_text_field_widget.dart';

class VerifyPinCodeTextWidget extends StatelessWidget {
  const VerifyPinCodeTextWidget({
    super.key,
    this.borderRadious,
    this.hintFontSize,
    this.controller,
    this.fieldHeight,
    this.fieldWidth,
    this.fontSize,
  });
  final double? hintFontSize;
  final double? borderRadious;
  final TextEditingController? controller;
  final double? fieldHeight;
  final double? fieldWidth;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: DefaultPinCodeTextFieldWidget(
        hintFontSize: hintFontSize,
        borderRadious: borderRadious,
        controller: controller,
        fieldHeight: fieldHeight,
        fieldWidth: fieldWidth,
        fontSize: fontSize,
        onChanged: (value) => controller?.text = value,
      ),
    );
  }
}
