import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/colors/styles.dart';
import '../../../../../../core/utils/constant/app_strings.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../../../../core/app_core.dart';
import '../../../../../core/app_notification.dart';
import '../../../../../core/services/toast_service.dart';
import '../../data/entity/district_entity.dart';
import '../../data/params/district_params.dart';
import '../../logic/district_cubit.dart';
import '../widgets/districts_view.dart';

class DistrictInput extends StatelessWidget {
  const DistrictInput({
    super.key,
    this.cityId,
    this.initialValue,
    this.onSelect,
    this.validator,
    this.fillColor,
    this.borderColor,
    this.hintStyle,
    this.style,
    this.titleStyle,
  });
  final DistrictEntity? initialValue;
  final Function(DistrictEntity)? onSelect;
  final String? Function(String?)? validator;
  final int? cityId;
  final Color? fillColor;
  final Color? borderColor;
  final TextStyle? hintStyle;
  final TextStyle? titleStyle;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DistrictsCubit()
        ..districtsStatesHandled(
          params: cityId != null
              ? DistrictParams(cityId: cityId!, page: 0, limit: 100000)
              : null,
        ),
      child: BlocConsumer<DistrictsCubit, DistrictState>(
        listener: (context, state) {
          if (state is GetDistrictsError) {
            ToastService.showCustom(
              message: state.error.message,
              context: context,
              toastStatusType: ToastStatusType.error,
              errorEntity: state.error,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<DistrictsCubit>();
          return DefaultFormField(
            titleText: AppStrings.district.tr,
            hintText: '${AppStrings.selectDistrict.tr}...',
            needValidation: validator != null,
            validator: validator,
            controller: TextEditingController(text: initialValue?.name ?? ''),
            readOnly: true,
            fillColor: fillColor,
            borderColor: borderColor,
            hintStyle: hintStyle,
            titleStyle: titleStyle,
            style: style,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: AppColors.kGeryText,
            ),
            onTap: () {
              if (cityId == null) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.youHveToSelectCityFirst.tr,
                    backgroundColor: AppColors.textError,
                  ),
                );
                return;
              }
              if (cubit.districts != null && cubit.districts!.isNotEmpty) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.9,
                  ),
                  enableDrag: true,
                  builder: (modalContext) {
                    return BlocProvider.value(
                      value: context.read<DistrictsCubit>(),
                      child: BlocBuilder<DistrictsCubit, DistrictState>(
                          builder: (context, state) {
                        return DistrictsView(
                          modalContext: modalContext,
                          data: cubit.districts!,
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
              if (cubit.districts != null && cubit.districts!.isEmpty) {
                cubit.districtsStatesHandled(
                  params: cityId != null
                      ? DistrictParams(cityId: cityId!, page: 0, limit: 100000)
                      : null,
                );
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.no_data.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
                return;
              }

              if (state is GetDistrictsLoading) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.loading.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
                return;
              }
              if (state is GetDistrictsError) {
                cubit.districtsStatesHandled(
                  params: cityId != null
                      ? DistrictParams(cityId: cityId!, page: 0, limit: 100000)
                      : null,
                );
                return;
              }
            },
          );
        },
      ),
    );
  }
}
