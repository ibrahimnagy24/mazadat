import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../assets/app_svg.dart';
import '../../utils/widgets/text/main_text.dart';
import '../../theme/text_styles/text_styles.dart';
import '../../utils/enums/enums.dart';
import '../../utils/extensions/media_query_helper.dart';

class GenderInput extends StatelessWidget {
  const GenderInput({
    super.key,
    this.initialValue,
    this.onSelect,
    this.validator,
  });
  final GenderTypes? initialValue;
  final Function(GenderTypes)? onSelect;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return DefaultFormField(
      titleText: AppStrings.gender.tr,
      hintText: '${AppStrings.selectGender.tr}...',
      needValidation: validator != null,
      validator: validator,
      controller: TextEditingController(
          text: initialValue != null ? (initialValue?.name ?? '').tr : null),
      readOnly: true,
      suffixIcon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 18,
        color: AppColors.kGeryText,
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          constraints: const BoxConstraints(minHeight: 207),
          builder: (modalContext) {
            return SafeArea(
              child: _GenderView(
                data: GenderTypes.values,
                initialValue: initialValue?.index,
                modalContext: modalContext,
                onSelect: (v) {
                  onSelect?.call(v);
                  Navigator.pop(modalContext);
                },
              ),
            );
          },
        );
        // CustomBottomSheet.show(
        //   label: AppStrings.selectGender.tr,
        //   widget: _GenderView(
        //     data: GenderTypes.values,
        //     initialValue: initialValue?.index,
        //     onSelect: (v) {
        //       onSelect?.call(v);
        //     },
        //   ),
        // );
      },
    );
  }
}

class _GenderView extends StatefulWidget {
  const _GenderView({
    required this.data,
    this.initialValue,
    this.onSelect,
    required this.modalContext,
  });
  final int? initialValue;
  final List<GenderTypes> data;
  final Function(GenderTypes)? onSelect;
  final BuildContext modalContext;

  @override
  State<_GenderView> createState() => __GenderViewState();
}

class __GenderViewState extends State<_GenderView> {
  int? _selectedItem;
  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedItem = widget.initialValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 60,
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(46, 46, 46, 1),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MainText(
                text: AppStrings.selectGender.tr,
                style: AppTextStyles.textLMedium,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(widget.modalContext);
                },
                child: const Icon(
                  Icons.close,
                  color: Color.fromRGBO(22, 22, 22, 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              widget.data.length,
              (index) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() => _selectedItem = widget.data[index].index);
                      widget.onSelect?.call(widget.data[index]);
                    },
                    child: Container(
                      height: 56,
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
                          SvgPicture.asset(
                            AppSvg.gender(widget.data[index].name),
                            width: 24,
                            height: 24,
                            color: AppColors.HEADER,
                          ),
                          const SizedBox(width: 14),
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
                                ? const Color.fromRGBO(81, 94, 50, 1)
                                : const Color.fromRGBO(162, 162, 162, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.data.length - 1 != index)
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color.fromRGBO(232, 232, 232, 1),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
