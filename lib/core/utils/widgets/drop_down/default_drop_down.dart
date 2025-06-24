import 'package:flutter/material.dart';
import '../../../theme/colors/styles.dart';
import '../../../theme/text_styles/text_styles.dart';
import '../text/main_text.dart';

class DefaultDropDownFieldWidget<T> extends StatefulWidget {
  const DefaultDropDownFieldWidget({
    super.key,
    this.stringItems = const [],
    this.initialValue,
    this.onChanged,
    this.titleText,
    this.hintText,
    this.labelText,
    this.validator,
    this.needValidation = true,
    this.enabled = true,
    this.compareById = false,
    this.idField = 'id',
    this.displayField = 'name',
    this.width,
    this.fillColor,
    this.borderColor,
    this.labelColor,
    this.textColor,
    this.borderRadius,
    this.style,
    this.prefixIcon,
    this.suffixIcon,
    this.onSaved,
    this.items = const [],
    //default 14.sp
    this.titleFontSize,
    //default 14.sp
    this.hintFontSize,
    this.titleIconWidget,
  });

  final List<dynamic> stringItems;
  final dynamic initialValue;
  final Function(dynamic)? onChanged;
  final String? titleText;
  final String? hintText;
  final String? labelText;
  final String? Function(dynamic)? validator;
  final bool needValidation;
  final bool enabled;
  final bool compareById;
  final String idField;
  final String displayField;
  final double? width;
  final Color? fillColor;
  final Color? borderColor;
  final Color? labelColor;
  final Color? textColor;
  final double? borderRadius;
  final TextStyle? style;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(dynamic)? onSaved;
  final List<DropdownMenuItem<dynamic>> items;
  final double? titleFontSize;
  final double? hintFontSize;
  final Widget? titleIconWidget;

  @override
  State<DefaultDropDownFieldWidget<T>> createState() =>
      _DefaultDropDownFieldWidgetState<T>();
}

class _DefaultDropDownFieldWidgetState<T>
    extends State<DefaultDropDownFieldWidget<T>> {
  dynamic selectedValue;
  late List<dynamic> uniqueItems;

  @override
  void initState() {
    super.initState();
    _initializeItems();
    _setInitialValue();
  }

  void _initializeItems() {
    if (widget.compareById) {
      // Remove duplicates based on ID
      final seen = <dynamic>{};
      uniqueItems = widget.stringItems.where((item) {
        final id = _getValue(item, widget.idField);
        return seen.add(id);
      }).toList();
    } else {
      // Remove complete duplicates
      uniqueItems = widget.stringItems.toSet().toList();
    }
  }

  void _setInitialValue() {
    if (widget.initialValue == null) return;

    if (widget.compareById) {
      final initialId = widget.initialValue is Map
          ? widget.initialValue[widget.idField]
          : _getValue(widget.initialValue, widget.idField);

      selectedValue = uniqueItems.firstWhere(
        (item) => _getValue(item, widget.idField) == initialId,
        orElse: () => null,
      );
    } else {
      selectedValue = widget.initialValue;
    }
  }

  dynamic _getValue(dynamic item, String field) {
    if (item is Map) {
      return item[field];
    } else {
      // Assuming item is a model with properties
      try {
        return item.toJson()[field]; // If your model has toJson()
      } catch (e) {
        try {
          return item.$fields[field]; // For some generated models
        } catch (e) {
          return item; // Return the item itself if no field access method works
        }
      }
    }
  }

  String _getDisplayText(dynamic item) {
    if (item == null) return '';
    return _getValue(item, widget.displayField)?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.titleText != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.titleIconWidget ?? const SizedBox.shrink(),
                  MainText(
                    text: widget.titleText!,
                    style: AppTextStyles.balooBhaijaan2W400Size14KPrimary1000
                        .copyWith(fontSize: widget.titleFontSize ?? 14),
                  ),
                ],
              ),
            ),
          DropdownButtonFormField<dynamic>(
            value: selectedValue,
            items: widget.items.isNotEmpty
                ? widget.items
                : uniqueItems.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(_getDisplayText(item)),
                    );
                  }).toList(),
            onChanged: widget.enabled
                ? (value) {
                    setState(() => selectedValue = value);
                    if (widget.onChanged != null) {
                      widget.onChanged!(value);
                    }
                  }
                : null,
            onSaved: widget.onSaved,
            validator: widget.validator ??
                (widget.needValidation
                    ? (value) => value == null
                        ? 'AppStrings.thisFieldIsRequired.tr'
                        : null
                    : null),
            style: widget.style ??
                AppTextStyles.balooBhaijaan2W400Size14KPrimary1000
                    .copyWith(fontSize: widget.titleFontSize ?? 14),
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.fillColor ?? AppColors.kWhite,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              labelText: widget.labelText,
              hintText: widget.hintText,
              hintStyle: AppTextStyles.balooBhaijaan2W400Size14GreyText3
                  .copyWith(fontSize: widget.hintFontSize ?? 14),
              labelStyle: AppTextStyles.balooBhaijaan2W400Size14KPrimary1000
                  .copyWith(fontSize: widget.titleFontSize ?? 14),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? AppColors.kOpacityGrey,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 24),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? AppColors.kOpacityGrey,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 24),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFFF0000),
                ),
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? 24,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFFF0000),
                ),
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? 24,
                ),
              ),
              contentPadding:
                  const EdgeInsetsDirectional.fromSTEB(24, 10, 10, 10),
            ),
          ),
        ],
      ),
    );
  }
}
