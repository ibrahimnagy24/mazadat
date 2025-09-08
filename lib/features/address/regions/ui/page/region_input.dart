import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/colors/styles.dart';
import '../../../../../../core/utils/constant/app_strings.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../../../../core/app_core.dart';
import '../../../../../core/app_notification.dart';
import '../../../../../core/services/toast_service.dart';
import '../../data/entity/region_entity.dart';
import '../../logic/region_cubit.dart';
import '../widgets/regions_view.dart';

class RegionInput extends StatelessWidget {
  const RegionInput({
    super.key,
    this.initialValue,
    this.onSelect,
    this.validator,
    this.fillColor,
    this.borderColor,
  });
  final RegionEntity? initialValue;
  final Function(RegionEntity)? onSelect;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegionsCubit()..regionsStatesHandled(),
      child: BlocConsumer<RegionsCubit, RegionState>(
        listener: (context, state) {
          if (state is GetRegionsError) {
            ToastService.showCustom(
              message: state.error.message,
              context: context,
              toastStatusType: ToastStatusType.error,
              errorEntity: state.error,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<RegionsCubit>();
          return DefaultFormField(
            titleText: AppStrings.region.tr,
            hintText: '${AppStrings.selectRegion.tr}...',
            needValidation: validator != null,
            validator: validator,
            controller: TextEditingController(text: initialValue?.name ?? ''),
            readOnly: true,
            fillColor: fillColor,
            borderColor: borderColor,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: AppColors.kGeryText,
            ),
            onTap: () {
              if (cubit.regions != null && cubit.regions!.isNotEmpty) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.9,
                  ),
                  enableDrag: true,
                  builder: (modalContext) {
                    return BlocProvider.value(
                      value: context.read<RegionsCubit>(),
                      child: BlocBuilder<RegionsCubit, RegionState>(
                          builder: (context, state) {
                        return RegionsView(
                          modalContext: modalContext,
                          data: cubit.regions!,
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
              if (cubit.regions != null && cubit.regions!.isEmpty) {
                cubit.regionsStatesHandled();
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.no_data.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
                return;
              }

              if (state is GetRegionsLoading) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.loading.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
                return;
              }
              if (state is GetRegionsError) {
                cubit.regionsStatesHandled();
                return;
              }
            },
          );
        },
      ),
    );
  }
}
