import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/colors/styles.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../text/main_text.dart';

class DefaultFormField extends StatelessWidget {
  const DefaultFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.onSaved,
    this.width,
    this.prefixIcon,
    this.suffixIcon,
    this.needValidation = true,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.errorMaxLines,
    this.enabled = true,
    this.fillColor,
    this.borderColor,
    this.verticalEdge,
    this.initialValue,
    this.labelColor,
    this.maxLines,
    this.textColor,
    this.controller,
    this.onChanged,
    this.elevation,
    this.padding,
    this.margin,
    this.prefixIconConstraints,
    this.maxLength = -1,
    this.borderRadious,
    this.titleText,
    this.decoration,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.textInputAction,
    this.onTapOutside,
    this.titleFontWeight,
    this.titleFontSize,
    this.autovalidateMode,
    this.titleStyle,
    this.style,
    this.autofocus = false,
    this.readOnly,
    this.titleIconWidget,
    this.hintStyle,
    this.hintTextMaxLines,
    this.contentPadding,
    this.errorText,
    this.errorStyle,
    this.enabledBorderColor,
    this.foucsBorderColor,
    this.inactiveBorderColor,
  });

  final String? labelText;
  final String? hintText;
  final void Function(String? newValue)? onSaved;
  final double? width;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? needValidation;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final bool? obscureText;
  final int? errorMaxLines;
  final bool? enabled;
  final Color? fillColor;
  final Color? borderColor;
  final double? verticalEdge;
  final String? initialValue;
  final Color? labelColor;
  final int? maxLines;
  final Color? textColor;
  final TextEditingController? controller;
  final void Function(String value)? onChanged;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxConstraints? prefixIconConstraints;
  final int? maxLength;
  final double? borderRadious;
  final String? titleText;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String value)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final void Function(PointerDownEvent)? onTapOutside;
  final FontWeight? titleFontWeight;
  final double? titleFontSize;
  final AutovalidateMode? autovalidateMode;
  final TextStyle? titleStyle;
  final TextStyle? style;
  final bool autofocus;
  final bool? readOnly;
  final Widget? titleIconWidget;
  final TextStyle? hintStyle;
  final int? hintTextMaxLines;
  final EdgeInsetsGeometry? contentPadding;
  final String? errorText;
  final TextStyle? errorStyle;
  final Color? enabledBorderColor;
  final Color? foucsBorderColor;
  final Color? inactiveBorderColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: verticalEdge ?? 0),
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (titleText != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    titleIconWidget ?? const SizedBox.shrink(),
                    MainText(
                      text: titleText!,
                      style: titleStyle ?? AppTextStyles.bodyXsReq,
                    ),
                  ],
                ),
              ),
            Padding(
              padding: titleText != null
                  ? const EdgeInsetsDirectional.only(bottom: 0)
                  : EdgeInsets.zero,
              child: TextFormField(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                readOnly: readOnly ?? false,
                autofocus: autofocus,
                onTapOutside: onTapOutside ??
                    (pointer) {
                      FocusScope.of(context).unfocus();
                    },
                textInputAction: textInputAction,
                maxLength: maxLength == -1 ? null : maxLength,
                inputFormatters: inputFormatters,
                cursorColor: AppColors.kPrimary1000,
                cursorHeight: 20,
                cursorWidth: 1,
                validator: validator ??
                    (needValidation!
                        ? (value) => value!.isEmpty
                            ? 'AppStrings.thisFieldIsRequired.tr'
                            : null
                        : null),
                autovalidateMode:
                    autovalidateMode ?? AutovalidateMode.onUserInteraction,
                keyboardType: keyboardType,
                controller: controller,
                obscureText: obscureText!,
                enabled: enabled,
                onFieldSubmitted: onFieldSubmitted,
                initialValue: initialValue,
                onSaved: onSaved,
                maxLines: maxLines == -1 ? null : maxLines ?? 1,
                onChanged: onChanged,
                style: style ?? TextStyle(color: textColor ?? AppColors.kBlack),
                decoration: decoration ??
                    InputDecoration(
                      filled: true,
                      fillColor: fillColor ?? AppColors.kWhite,
                      errorMaxLines: errorMaxLines ?? 2,
                      errorText: errorText,
                      suffixIcon: suffixIcon,
                      errorStyle: errorStyle,
                      prefixIconConstraints: prefixIconConstraints,
                      prefixIcon: prefixIcon,
                      labelText: labelText,
                      labelStyle: labelColor != null
                          ? TextStyle(color: labelColor ?? AppColors.kGeryText)
                          : AppTextStyles.balooBhaijaan2W400Size14GreyText2,
                      hintStyle: hintStyle ??
                          (labelColor != null
                              ? TextStyle(
                                  color: labelColor ?? AppColors.kGeryText,
                                  fontSize: 12,
                                )
                              : AppTextStyles
                                  .balooBhaijaan2W400Size14GreyText3),
                      hintText: hintText,
                      hintMaxLines: hintTextMaxLines ?? 2,
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: inactiveBorderColor ??
                              borderColor ??
                              AppColors.kBlack,
                          width: 1.0,
                        ),
                        borderRadius:
                            BorderRadius.circular(borderRadious ?? 24),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: enabledBorderColor ??
                              borderColor ??
                              AppColors.kOpacityGrey2,
                          width: 1.0,
                        ),
                        borderRadius:
                            BorderRadius.circular(borderRadious ?? 24),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFFF0000),
                          width: 1.0,
                        ),
                        borderRadius:
                            BorderRadius.circular(borderRadious ?? 24),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(borderRadious ?? 24),
                        borderSide: BorderSide(
                          color: foucsBorderColor ??
                              borderColor ??
                              AppColors.kOpacityGrey2,
                        ),
                      ),
                      contentPadding: contentPadding ??
                          const EdgeInsetsDirectional.fromSTEB(12, 10, 10, 10),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: borderColor ?? AppColors.kPrimary,
                          width: 1.0,
                        ),
                        borderRadius:
                            BorderRadius.circular(borderRadious ?? 24),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
