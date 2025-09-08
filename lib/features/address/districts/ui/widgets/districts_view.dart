import 'package:flutter/material.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../data/entity/district_entity.dart';

class DistrictsView extends StatefulWidget {
  const DistrictsView({
    super.key,
    required this.data,
    this.initialValue,
    this.onSelect,
    required this.modalContext,
    this.showSearch = true,
  });
  final List<DistrictEntity> data;
  final int? initialValue;
  final Function(DistrictEntity)? onSelect;
  final BuildContext modalContext;
  final bool showSearch;

  @override
  State<DistrictsView> createState() => _DistrictsViewState();
}

class _DistrictsViewState extends State<DistrictsView> {
  int? _selectedItem;
  final TextEditingController _searchController = TextEditingController();
  List<DistrictEntity> _filteredData = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedItem = widget.initialValue;
      _filteredData = widget.data;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterDistricts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredData = widget.data;
      } else {
        _filteredData = widget.data
            .where(
                (district) => district.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
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
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
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
                  text: AppStrings.selectDistrict.tr,
                  style: AppTextStyles.textLMedium,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Color.fromRGBO(22, 22, 22, 1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (widget.showSearch) ...[
              TextField(
                controller: _searchController,
                onChanged: _filterDistricts,
                decoration: InputDecoration(
                  hintText: AppStrings.search.tr,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Color.fromRGBO(81, 94, 50, 1)),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      _filteredData.length,
                      (index) => Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() =>
                                  _selectedItem = _filteredData[index].id);
                              widget.onSelect?.call(_filteredData[index]);
                            },
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: (_filteredData.length - 1) == index
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
                                      _filteredData[index].name,
                                      style: AppTextStyles.textXLMedium,
                                    ),
                                  ),
                                  Icon(
                                    _selectedItem == _filteredData[index].id
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off,
                                    size: 24,
                                    color: _selectedItem ==
                                            _filteredData[index].id
                                        ? const Color.fromRGBO(81, 94, 50, 1)
                                        : const Color.fromRGBO(
                                            162, 162, 162, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (_filteredData.length - 1 != index)
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: Color.fromRGBO(232, 232, 232, 1),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
