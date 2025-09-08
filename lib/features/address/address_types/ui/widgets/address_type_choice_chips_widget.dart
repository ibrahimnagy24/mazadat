import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/services/pagination/pagination_service.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../data/entity/address_type_entity.dart';
import '../../logic/address_types_cubit.dart';

class AddressTypeChoiceChipsWidget extends StatefulWidget {
  const AddressTypeChoiceChipsWidget({
    super.key,
    this.initialValue,
    this.validator,
    this.onSelect,
  });

  final AddressTypeEntity? initialValue;
  final String? Function(AddressTypeEntity?)? validator;
  final void Function(AddressTypeEntity?)? onSelect;

  @override
  State<AddressTypeChoiceChipsWidget> createState() =>
      _AddressTypeChoiceChipsWidgetState();
}

class _AddressTypeChoiceChipsWidgetState
    extends State<AddressTypeChoiceChipsWidget> {
  AddressTypeEntity? selectedType;

  @override
  void initState() {
    super.initState();
    selectedType = widget.initialValue;
    // Initialize the cubit with search parameters
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddressTypesCubit>().addressTypesStatesHandled(
            SearchEngine(currentPage: -1),
          );
    });
  }

  @override
  void didUpdateWidget(AddressTypeChoiceChipsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update selectedType when initialValue changes
    if (widget.initialValue != oldWidget.initialValue) {
      selectedType = widget.initialValue;
    }
  }

  // Static method to get icon for address type based on name
  String _getIconForAddressType(String name) {
    final lowerName = name.toLowerCase();
    if (lowerName.contains('home') ||
        lowerName.contains('منزل') ||
        lowerName.contains('بيت') ||
        lowerName.contains('house') ||
        lowerName.contains('المنزل')) {
      return AppSvg.homeIcon;
    } else if (lowerName.contains('office') ||
        lowerName.contains('مكتب') ||
        lowerName.contains('عمل') ||
        lowerName.contains('company') ||
        lowerName.contains('شركة')) {
      return AppSvg.officePlaza;
    }
    // Default icon for other types
    return AppSvg.homeIcon;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressTypesCubit, AddressTypesState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainText(
              text: AppStrings.addressType.tr,
              style: AppTextStyles.textLgMedium,
            ),
            const SizedBox(height: 8),
            if (state is AddressTypesLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (state is AddressTypesError)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ErrorMessageWidget(
                    message: state.error.message,
                    error: state.error,
                    onTap: () {
                      context
                          .read<AddressTypesCubit>()
                          .addressTypesStatesHandled(SearchEngine());
                    },
                  ),
                ),
              )
            else if (state is AddressTypesDone)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: state.addressTypes.map((type) {
                  // Ensure selectedType is synced with initialValue when data loads
                  if (selectedType == null && widget.initialValue != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() {
                          selectedType = widget.initialValue;
                        });
                      }
                    });
                  }
                  final isSelected = selectedType?.id == type.id;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedType = type;
                      });
                      widget.onSelect?.call(type);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color.fromRGBO(81, 94, 50, 0.1)
                            : AppColors.kWhite,
                        border: Border.all(
                          color: isSelected
                              ? const Color.fromRGBO(81, 94, 50, 1)
                              : const Color.fromRGBO(209, 209, 209, 1),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MainText(
                            text: type.name,
                            style: AppTextStyles.textMdRegular.copyWith(
                              color: isSelected
                                  ? const Color.fromRGBO(81, 94, 50, 1)
                                  : AppColors.textSecondaryParagraph,
                            ),
                          ),
                          const SizedBox(width: 4),
                          SvgPicture.asset(
                            _getIconForAddressType(type.name),
                            color: isSelected
                                ? const Color.fromRGBO(81, 94, 50, 1)
                                : AppColors.textSecondaryParagraph,
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )
            else if (state is AddressTypesEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'No address types available',
                    style: AppTextStyles.textMdRegular.copyWith(
                      color: AppColors.textSecondaryParagraph,
                    ),
                  ),
                ),
              ),
            if (widget.validator != null)
              Builder(
                builder: (context) {
                  final error = widget.validator?.call(selectedType);
                  if (error != null) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        error,
                        style: AppTextStyles.textSmRegular.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
          ],
        );
      },
    );
  }
}
