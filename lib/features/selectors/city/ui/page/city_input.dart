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
import '../../data/entity/city_entity.dart';
import '../../logic/city_cubit.dart';
import '../widgets/cities_view.dart';

class CityInput extends StatelessWidget {
  const CityInput(
      {super.key,
      this.regionId,
      this.initialValue,
      this.onSelect,
      this.validator});
  final CityEntity? initialValue;
  final Function(CityEntity)? onSelect;
  final String? Function(String?)? validator;
  final int? regionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CityCubit()..citiesStatesHandled(SearchEngine(id: regionId)),
      child: BlocBuilder<CityCubit, CityState>(
        builder: (context, state) {
          final cubit = context.read<CityCubit>();
          return DefaultFormField(
            titleText: AppStrings.city.tr,
            hintText: '${AppStrings.selectCity.tr}...',
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
              if (state is CityDone) {
                CustomBottomSheet.show(
                    label: AppStrings.selectCity.tr,
                    widget: BlocProvider.value(
                      value: context.read<CityCubit>(),
                      child: BlocBuilder<CityCubit, CityState>(
                          builder: (context, state) {
                        return Column(
                          children: [
                            Expanded(
                              child: CitiesView(
                                controller:
                                    context.read<CityCubit>().controller,
                                data: (state as CityDone).cities,
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
              } else if (state is CityLoading) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.loading.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
              } else if (state is CityEmpty) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.no_data.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
              } else if (state is CityError) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.somethingWentWrong,
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
