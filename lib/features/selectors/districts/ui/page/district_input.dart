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
import '../../data/entity/district_entity.dart';
import '../../logic/district_cubit.dart';
import '../widgets/districts_view.dart';

class DistrictInput extends StatelessWidget {
  const DistrictInput(
      {super.key,
      required this.cityId,
      this.initialValue,
      this.onSelect,
      this.validator});
  final DistrictEntity? initialValue;
  final Function(DistrictEntity)? onSelect;
  final String? Function(String?)? validator;

  final int cityId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DistrictsCubit()..districtsStatesHandled(SearchEngine(id: cityId)),
      child: BlocBuilder<DistrictsCubit, DistrictState>(
        builder: (context, state) {
          final cubit = context.read<DistrictsCubit>();
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
              if (state is DistrictSuccess) {
                CustomBottomSheet.show(
                    label: AppStrings.selectRegion.tr,
                    widget: BlocProvider.value(
                      value: context.read<DistrictsCubit>(),
                      child: BlocBuilder<DistrictsCubit, DistrictState>(
                          builder: (context, state) {
                        return Column(
                          children: [
                            Expanded(
                              child: DistrictsView(
                                controller:
                                    context.read<DistrictsCubit>().controller,
                                data: (state as DistrictSuccess).districts,
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
              } else if (state is DistrictLoading) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.loading.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
              } else if (state is DistrictEmpty) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.no_data.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
              } else if (state is DistrictError) {
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
