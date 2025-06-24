import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../text/main_text.dart';
import '../../../theme/colors/styles.dart';

class DefaultDropDownMultiChoices extends StatelessWidget {
  const DefaultDropDownMultiChoices({
    super.key,
    required this.options,
    this.onChanged,
    this.titleText,
    this.needValidation = true,
    this.validator,
    this.hintText,
    this.labelText,
    this.onSaved,
    this.prefixIcon,
    this.prefixIconData,
    this.suffixIcon,
    this.labelColor,
    this.decoration,
    this.enabled,
    this.errorMaxLines,
    this.fillColor,
    this.prefixIconConstraints,
    this.borderColor,
    this.borderRadious,
  });
  final List<FormBuilderFieldOption<Object?>> options;
  final void Function(List<Object?>? value)? onChanged;
  final String? titleText;
  final bool? needValidation;
  final String? Function(List<Object?>?)? validator;
  final String? labelText;
  final String? hintText;
  final Function(List<Object?>? newValue)? onSaved;
  final IconData? prefixIconData;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? labelColor;
  final InputDecoration? decoration;
  final int? errorMaxLines;
  final bool? enabled;
  final Color? fillColor;
  final BoxConstraints? prefixIconConstraints;
  final Color? borderColor;
  final double? borderRadious;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (titleText != null)
          MainText(
            text: titleText!,
            fontSize: 14,
          ),
        Padding(
          padding: titleText != null
              ? const EdgeInsetsDirectional.only(start: 6, bottom: 6)
              : EdgeInsets.zero,
          child: FormBuilderCheckboxGroup(
            name: 'name',
            activeColor: AppColors.kPrimary1000,
            checkColor: AppColors.kWhite,
            onSaved: onSaved,
            decoration: decoration ??
                InputDecoration(
                  filled: true,
                  fillColor: fillColor ?? AppColors.transparent,
                  errorMaxLines: errorMaxLines,
                  suffixIcon: suffixIcon,
                  prefixIconConstraints: prefixIconConstraints,
                  prefixIcon: prefixIcon,
                  labelText: labelText,
                  labelStyle: TextStyle(color: labelColor ?? Colors.black),
                  hintStyle: TextStyle(
                      color: labelColor ?? AppColors.kOpacityGrey2,
                      fontSize: 12),
                  hintText: hintText,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor ?? const Color(0x28626262),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFFF0000),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadious ?? 8),
                    borderSide: BorderSide(
                      color: borderColor ?? AppColors.kPrimary1000,
                    ),
                  ),
                  contentPadding: EdgeInsets.zero,
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor ?? const Color(0xFFFF0000),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
            visualDensity: const VisualDensity(horizontal: -4, vertical: 0),
            options: options,
            onChanged: onChanged,
            validator: validator ??
                (needValidation!
                    ? (value) => value == null || value.isEmpty
                        ? 'AppStrings.thisFieldIsRequired'
                        : null
                    : null),
          ),
        ),
      ],
    );
  }
}
