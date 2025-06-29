import 'package:flutter/material.dart';

import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/extensions/media_query_helper.dart';
import '../../data/entity/city_entity.dart';

class CitiesView extends StatefulWidget {
  const CitiesView(
      {super.key, required this.data, this.initialValue, this.onSelect});
  final List<CityEntity> data;
  final int? initialValue;
  final Function(CityEntity)? onSelect;

  @override
  State<CitiesView> createState() => _CitiesViewState();
}

class _CitiesViewState extends State<CitiesView> {
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
    return Column(
      children: List.generate(
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
