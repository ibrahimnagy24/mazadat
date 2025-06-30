import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors/styles.dart';
import '../../../theme/radiuos/app_radius.dart';
import '../../../theme/text_styles/text_styles.dart';

import '../../constant/app_strings.dart';
import '../../extensions/extensions.dart';
import '../../validations/validator.dart';
import '../misc/verifiy_password_widget.dart';
import 'default_form_field.dart';

class DefaultPasswordFormField extends StatefulWidget {
  const DefaultPasswordFormField({
    super.key,
    //default 14.sp
    this.titleFontSize,
    //default 14.sp
    this.hintFontSize,
    //default 24.sp
    this.titleIconSize,
    //default 24.r
    this.borderRadious,
    this.controller,
    this.titleText,
    this.hintText,
    this.validator,
    this.readOnly = false,
    this.needValidation = true,
    this.onChanged,
    this.needPasswordStrength = false,
  });
  final double? titleFontSize;
  final double? hintFontSize;
  final double? titleIconSize;
  final double? borderRadious;
  final TextEditingController? controller;
  final String? titleText;
  final String? hintText;
  final String? Function(String? value)? validator;
  final bool readOnly;
  final bool needValidation;
  final void Function(String value)? onChanged;
  final bool needPasswordStrength;
  @override
  State<DefaultPasswordFormField> createState() =>
      _DefaultPasswordFormFieldState();
}

class _DefaultPasswordFormFieldState extends State<DefaultPasswordFormField> {
  bool isPasswordVisible = true;
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultFormField(
          titleText: widget.titleText ?? AppStrings.password.tr,
          needValidation: widget.needValidation,
          hintText: widget.hintText ?? '***********',
          validator: widget.needValidation
              ? widget.validator ??
                  (value) => PasswordValidator.passwordValidator(value)
              : null,
          borderRadius: widget.borderRadious ?? AppRadius.rS,
          obscureText: isPasswordVisible,
          keyboardType: TextInputType.visiblePassword,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
            icon: isPasswordVisible
                ? const Icon(
                    CupertinoIcons.eye,
                    color: AppColors.kGeryText2,
                  )
                : const Icon(
                    CupertinoIcons.eye_slash,
                    color: AppColors.kGeryText2,
                  ),
          ),
          errorStyle: widget.needPasswordStrength
              ? const TextStyle(height: 0, fontSize: 0)
              : null,
          controller: widget.controller,
          onTapOutside: (p0) {},
          readOnly: widget.readOnly,
          onChanged: widget.onChanged ??
              (value) {
                if (mounted) {
                  setState(() {
                    password = value;
                  });
                }
              },
        ),
        if (widget.controller != null && widget.needPasswordStrength)
          VerifiPasswordWidget(password: widget.controller!.text),
      ],
    );
  }
}
