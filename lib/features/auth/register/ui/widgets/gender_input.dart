import 'package:flutter/material.dart';
import '../../../../../../core/theme/colors/styles.dart';
import '../../../../../../core/utils/constant/app_strings.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/validations/validator.dart';
import '../../../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/enums/enums.dart';
import '../../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../../core/utils/widgets/bottom_sheets/confirm_bottom_sheet.dart';

class GenderInput extends StatelessWidget {
  const GenderInput({super.key, this.initialValue, this.onSelect});
  final GenderTypes? initialValue;
  final Function(GenderTypes)? onSelect;

  @override
  Widget build(BuildContext context) {
    return DefaultFormField(
      titleText: AppStrings.gender.tr,
      hintText: '${AppStrings.selectGender.tr}...',
      validator: (v) => DefaultValidator.defaultValidator(
        initialValue?.name ?? '',
        label: AppStrings.gender.tr,
      ),
      controller: TextEditingController(text: initialValue?.name ?? ''),
      readOnly: true,
      suffixIcon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 18,
        color: AppColors.kGeryText,
      ),
      onTap: () {
        CustomBottomSheet.show(
          label: AppStrings.selectGender.tr,
          widget: GenderView(
            data: GenderTypes.values,
            initialValue: initialValue?.index,
            onSelect: (v) {
              onSelect?.call(v);
            },
          ),
          onConfirm: () => CustomNavigator.pop(),
        );
      },
    );
  }
}

class GenderView extends StatefulWidget {
  const GenderView(
      {super.key, required this.data, this.initialValue, this.onSelect});
  final int? initialValue;
  final List<GenderTypes> data;
  final Function(GenderTypes)? onSelect;

  @override
  State<GenderView> createState() => _GenderViewState();
}

class _GenderViewState extends State<GenderView> {
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
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.data.length,
        (index) => GestureDetector(
          onTap: () {
            setState(() => _selectedItem = widget.data[index].index);
            widget.onSelect?.call(widget.data[index]);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: AppColors.border,
              )),
            ),
            width: MediaQueryHelper.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.data[index].name.tr,
                    style: AppTextStyles.textXLMedium,
                  ),
                ),
                Icon(
                  _selectedItem == widget.data[index].index
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  size: 24,
                  color: _selectedItem == widget.data[index].index
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
