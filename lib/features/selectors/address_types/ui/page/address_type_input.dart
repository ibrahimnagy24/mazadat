import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/colors/styles.dart';
import '../../../../../../core/utils/constant/app_strings.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../../../../core/app_core.dart';
import '../../../../../core/app_notification.dart';
import '../../../../../core/services/pagination/pagination_service.dart';
import '../../../../../core/utils/widgets/bottom_sheets/confirm_bottom_sheet.dart';
import '../../../../../core/utils/widgets/custom_loading_text.dart';
import '../../data/entity/address_type_entity.dart';
import '../../logic/address_types_cubit.dart';
import '../widgets/address_types_view.dart';

class AddressTypeInput extends StatelessWidget {
  const AddressTypeInput(
      {super.key, this.initialValue, this.onSelect, this.validator});
  final AddressTypeEntity? initialValue;
  final Function(AddressTypeEntity)? onSelect;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddressTypesCubit()..addressTypesStatesHandled(SearchEngine()),
      child: BlocBuilder<AddressTypesCubit, AddressTypesState>(
        builder: (context, state) {
          final cubit = context.read<AddressTypesCubit>();
          return DefaultFormField(
            titleText: AppStrings.addressType.tr,
            hintText: '${AppStrings.selectAddressType.tr}...',
            needValidation: validator != null,
            validator: validator,
            controller: TextEditingController(text: initialValue?.name ?? ''),
            readOnly: true,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: AppColors.kGeryText,
            ),
            onTap: () {
              if (state is AddressTypesDone) {
                CustomBottomSheet.show(
                    label: AppStrings.selectAddressType.tr,
                    widget: BlocProvider.value(
                      value: context.read<AddressTypesCubit>(),
                      child: BlocBuilder<AddressTypesCubit, AddressTypesState>(
                          builder: (context, state) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: AddressTypesView(
                                controller: context
                                    .read<AddressTypesCubit>()
                                    .controller,
                                data: (state as AddressTypesDone).addressTypes,
                                initialValue: initialValue?.id,
                                onSelect: (v) {
                                  onSelect?.call(v);
                                },
                              ),
                            ),
                            CustomLoadingText(loading: state.isLoading),
                          ],
                        );
                      }),
                    ));
              } else if (state is AddressTypesLoading) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.loading.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
              } else if (state is AddressTypesEmpty) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.no_data.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
              } else if (state is AddressTypesError) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.somethingWentWrong.tr,
                    backgroundColor: AppColors.textError,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
