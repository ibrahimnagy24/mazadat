import 'package:flutter/material.dart';
import '../../../theme/colors/styles.dart';

import '../../../shared/widgets/custom_images.dart';
import '../text/main_text.dart';

class CustomDropList extends StatefulWidget {
  final Function(CustomSingleModel) onChanged;
  final String? headLabel;
  final String? hintText;
  final List<CustomSingleModel>? list;
  final CustomSingleModel? initialValue;
  final String? Function(dynamic)? validation;
  final bool? isReadOnly;
  final TextStyle? labelStyle, hintStyle;
  final EdgeInsets? padding;
  final Color? iconColor;
  final double? height;

  const CustomDropList({
    super.key,
    required this.onChanged,
    this.list,
    this.initialValue,
    this.headLabel,
    this.validation,
    this.hintText,
    this.isReadOnly = false,
    this.labelStyle,
    this.padding,
    this.hintStyle,
    this.iconColor,
    this.height,
  });

  @override
  State<CustomDropList> createState() => _CustomDropListState();
}

/// This is the private State class that goes with CustomDropList.
class _CustomDropListState extends State<CustomDropList> {
  late CustomSingleModel dropdownValue;

  @override
  void initState() {
    dropdownValue =
        widget.initialValue ?? CustomSingleModel(id: 0, name: 'Select One');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.headLabel != null)
            MainText(
              text: widget.headLabel,
              style: widget.labelStyle,
              color: AppColors.kBlack,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          if (widget.headLabel != null) const SizedBox(height: 4),
          Container(
            height: widget.height ?? 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.kWhite,
              border: Border.all(color: AppColors.SUB_HEADER.withOpacity(0.45)),
            ),
            alignment: Alignment.center,
            child: DropdownButtonFormField<CustomSingleModel>(
              icon: customImageIconSVG(
                  imageName: 'arrow-down',
                  color: widget.iconColor ?? AppColors.kPrimary),
              value: widget.initialValue != null
                  ? widget.list?.firstWhere(
                      (element) => element.id == widget.initialValue?.id)
                  : null,
              isExpanded: true,
              onChanged: widget.isReadOnly == false
                  ? (CustomSingleModel? newValue) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        dropdownValue = newValue!;
                      });
                      widget.onChanged(dropdownValue);
                    }
                  : null,
              validator: widget.validation,
              decoration: InputDecoration(
                  isDense: true,
                  hintText: widget.hintText,
                  // contentPadding: EdgeInsets.symmetric(vertical: 15.h),
                  hintStyle: widget.hintStyle ??
                      const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.SUB_HEADER),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none),
              items: widget.list?.map((CustomSingleModel value) {
                return DropdownMenuItem<CustomSingleModel>(
                  value: value,
                  child: MainText(
                    text: value.name ?? '',
                    textAlign: TextAlign.center,
                    style: widget.hintStyle ??
                        const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSingleModel {
  final int? id;
  final String? name;
  final String? value;

  CustomSingleModel({this.id, this.name, this.value});
}
