import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/colors/styles.dart';
import '../../../../../../core/utils/constant/app_strings.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../../../../core/app_core.dart';
import '../../../../../core/app_notification.dart';
import '../../../../../core/services/toast_service.dart';
import '../../data/entity/city_entity.dart';
import '../../data/params/city_params.dart';
import '../../logic/city_cubit.dart';
import '../widgets/cities_view.dart';

class CityInput extends StatelessWidget {
  const CityInput({
    super.key,
    this.withRegionFilter = false,
    this.loadAllCities = false,
    this.regionId,
    this.initialValue,
    this.onSelect,
    this.validator,
    this.fillColor,
    this.borderColor,
    this.hintStyle,
    this.titleStyle,
    this.style,
    this.suffixIconColor,
  });
  final CityEntity? initialValue;
  final Function(CityEntity)? onSelect;
  final String? Function(String?)? validator;
  final int? regionId;
  final bool withRegionFilter;
  final bool loadAllCities;
  final Color? fillColor;
  final Color? borderColor;
  final TextStyle? hintStyle;
  final TextStyle? titleStyle;
  final TextStyle? style;
  final Color? suffixIconColor;
  CityParams? _getCityParams() {
    if (loadAllCities) {
      // Load all cities without region filter
      return const CityParams(page: 0, limit: 100000);
    } else if (withRegionFilter && regionId != null) {
      // Load cities filtered by region
      return CityParams(regionId: regionId!, page: 0, limit: 100000);
    } else {
      // Use default behavior (hardcoded regionId from cubit)
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CityCubit()
        ..citiesStatesHandled(
          params: _getCityParams(),
        ),
      child: BlocConsumer<CityCubit, CityState>(
        listener: (context, state) {
          if (state is GetCitiesError) {
            ToastService.showCustom(
              message: state.error.message,
              context: context,
              toastStatusType: ToastStatusType.error,
              errorEntity: state.error,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<CityCubit>();
          return DefaultFormField(
            titleText: AppStrings.city.tr,
            hintText: AppStrings.selectCity.tr,
            needValidation: validator != null,
            validator: validator,
            controller: TextEditingController(text: initialValue?.name ?? ''),
            readOnly: true,
            fillColor: fillColor,
            borderColor: borderColor,
            suffixIcon: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: suffixIconColor ?? AppColors.kGeryText,
            ),
            hintStyle: hintStyle,
            titleStyle: titleStyle,
            style: style,
            onTap: () {
              if (regionId == null && withRegionFilter && !loadAllCities) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.youHveToSelectRegionFirst.tr,
                    backgroundColor: AppColors.textError,
                  ),
                );
                return;
              }
              if (cubit.cities != null && cubit.cities!.isNotEmpty) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.9,
                  ),
                  enableDrag: true,
                  builder: (modalContext) {
                    return BlocProvider.value(
                      value: context.read<CityCubit>(),
                      child: BlocBuilder<CityCubit, CityState>(
                          builder: (context, state) {
                        return CitiesView(
                          modalContext: modalContext,
                          data: cubit.cities!,
                          initialValue: initialValue?.id,
                          onSelect: (v) {
                            onSelect?.call(v);
                            Navigator.pop(modalContext);
                          },
                        );
                      }),
                    );
                  },
                );
                return;
              }
              if (cubit.cities != null && cubit.cities!.isEmpty) {
                cubit.citiesStatesHandled(params: _getCityParams());
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.no_data.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
                return;
              }

              if (state is GetCitiesLoading) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.loading.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
                return;
              }
              if (state is GetCitiesError) {
                cubit.citiesStatesHandled(params: _getCityParams());
                return;
              }
            },
          );
        },
      ),
    );
  }
}
