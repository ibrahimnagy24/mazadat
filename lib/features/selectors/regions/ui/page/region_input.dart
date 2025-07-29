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
import '../../data/entity/region_entity.dart';
import '../../logic/region_cubit.dart';
import '../widgets/regions_view.dart';

class RegionInput extends StatelessWidget {
  const RegionInput(
      {super.key,
      this.initialValue,
      this.onSelect,
      this.validator});
  final RegionEntity? initialValue;
  final Function(RegionEntity)? onSelect;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegionsCubit()..regionsStatesHandled(SearchEngine()),
      child: BlocBuilder<RegionsCubit, RegionState>(
        builder: (context, state) {
          final cubit = context.read<RegionsCubit>();
          return DefaultFormField(
            titleText: AppStrings.region.tr,
            hintText: '${AppStrings.selectRegion.tr}...',
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
              if (state is RegionSuccess) {
                CustomBottomSheet.show(
                    label: AppStrings.selectRegion.tr,
                    widget: BlocProvider.value(
                      value: context.read<RegionsCubit>(),
                      child: BlocBuilder<RegionsCubit, RegionState>(
                          builder: (context, state) {
                        return Column(
                          children: [
                            Expanded(
                              child: RegionsView(
                                controller:
                                    context.read<RegionsCubit>().controller,
                                data: (state as RegionSuccess).regions,
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
              } else if (state is RegionLoading) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.loading.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
              } else if (state is RegionEmpty) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.no_data.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
              } else if (state is RegionError) {
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
