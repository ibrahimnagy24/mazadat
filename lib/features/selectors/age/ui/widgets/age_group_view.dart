import 'package:flutter/material.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../data/entity/age_entity.dart';

class AgeGroupView extends StatefulWidget {
  const AgeGroupView({
    super.key,
    required this.data,
    this.initialValue,
    this.onSelect,
    required this.modalContext,
  });
  final List<AgeEntity> data;
  final int? initialValue;
  final Function(AgeEntity)? onSelect;
  final BuildContext modalContext;

  @override
  State<AgeGroupView> createState() => _AgeGroupViewState();
}

class _AgeGroupViewState extends State<AgeGroupView> {
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
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
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
                    text: AppStrings.selectAgeGroup.tr,
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
                  (index) {
                    final item = widget.data[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedItem = item.id);
                        widget.onSelect?.call(item);
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 56,
                            width: MediaQueryHelper.width,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item.name,
                                    style: AppTextStyles.textXLMedium.copyWith(
                                        color: const Color.fromRGBO(
                                            46, 46, 46, 1)),
                                  ),
                                ),
                                Icon(
                                  _selectedItem == item.id
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off,
                                  size: 24,
                                  color: _selectedItem == item.id
                                      ? const Color.fromRGBO(81, 94, 50, 1)
                                      : const Color.fromRGBO(162, 162, 162, 1),
                                ),
                              ],
                            ),
                          ),
                          if (widget.data.length - 1 != index)
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: Color.fromRGBO(232, 232, 232, .5),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
