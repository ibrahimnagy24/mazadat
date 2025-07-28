import 'package:flutter/material.dart';

import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../data/entity/region_entity.dart';

class RegionsView extends StatefulWidget {
  const RegionsView(
      {super.key,
      required this.data,
      required this.controller,
      this.initialValue,
      this.onSelect});
  final List<RegionEntity> data;
  final int? initialValue;
  final Function(RegionEntity)? onSelect;
  final ScrollController controller;
  @override
  State<RegionsView> createState() => _RegionsViewState();
}

class _RegionsViewState extends State<RegionsView> {
  int? _selectedItem;
  @override
  void initState() {
    setState(() {
      _selectedItem = widget.initialValue;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListAnimator(
      controller: widget.controller,
      data: List.generate(
        widget.data.length,
        (index) => GestureDetector(
          onTap: () {
            setState(() => _selectedItem = widget.data[index].id);
            widget.onSelect?.call(widget.data[index]);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: (widget.data.length - 1) == index
                      ? Colors.transparent
                      : AppColors.border,
                ),
              ),
            ),
            width: MediaQueryHelper.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.data[index].name,
                    style: AppTextStyles.textXLMedium,
                  ),
                ),
                Icon(
                  _selectedItem == widget.data[index].id
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  size: 24,
                  color: _selectedItem == widget.data[index].id
                      ? AppColors.kPrimary
                      : AppColors.iconDefault,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
