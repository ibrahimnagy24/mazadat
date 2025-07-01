import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/colors/styles.dart';
import '../../../../../../core/utils/constant/app_strings.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../../../../core/app_core.dart';
import '../../../../../core/app_notification.dart';
import '../../../../../core/utils/widgets/bottom_sheets/confirm_bottom_sheet.dart';
import '../../data/entity/city_entity.dart';
import '../../logic/city_cubit.dart';
import '../widgets/cities_view.dart';

class CityInput extends StatelessWidget {
  const CityInput({super.key, this.initialValue, this.onSelect});
  final CityEntity? initialValue;
  final Function(CityEntity)? onSelect;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CityCubit()..citiesStatesHandled(),
      child: BlocBuilder<CityCubit, CityState>(
        buildWhen: (previous, current) =>
            current is CityLoading ||
            current is CityDone ||
            current is CityError,
        builder: (context, state) {
          final cubit = context.read<CityCubit>();
          return DefaultFormField(
            titleText: AppStrings.city.tr,
            hintText: '${AppStrings.selectCity.tr}...',
            needValidation: false,
            // validator: (v) => DefaultValidator.defaultValidator(
            //   initialValue?.name ?? '',
            //   label: AppStrings.city.tr,
            // ),
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
                  widget: CitiesView(
                    data: state.cities,
                    initialValue: initialValue?.id,
                    onSelect: (v) {
                      onSelect?.call(v);
                    },
                  ),
                );
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
