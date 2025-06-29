import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/colors/styles.dart';
import '../../../../../../core/utils/constant/app_strings.dart';
import '../../../../../../core/utils/extensions/extensions.dart';
import '../../../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../../../../core/app_core.dart';
import '../../../../../core/app_notification.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/utils/widgets/bottom_sheets/confirm_bottom_sheet.dart';
import '../../data/entity/age_entity.dart';
import '../../logic/age_cubit.dart';
import '../widgets/age_group_view.dart';

class AgeInput extends StatelessWidget {
  const AgeInput({super.key, this.initialValue, this.onSelect});
  final AgeEntity? initialValue;
  final Function(AgeEntity)? onSelect;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AgeCubit()..citiesStatesHandled(),
      child: BlocBuilder<AgeCubit, AgeState>(
        buildWhen: (previous, current) =>
            current is AgeLoading || current is AgeDone || current is AgeError,
        builder: (context, state) {
          final cubit = context.read<AgeCubit>();
          return DefaultFormField(
            titleText: AppStrings.age.tr,
            hintText: '${AppStrings.selectAge.tr}...',
            needValidation: false,
            // validator: (v) => DefaultValidator.defaultValidator(
            //   initialValue?.name ?? '',
            //   label: AppStrings.age.tr,
            // ),
            controller: TextEditingController(text: initialValue?.name ?? ''),
            readOnly: true,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: AppColors.textSecondaryParagraph,
            ),
            onTap: () {
              if (state is AgeDone) {
                CustomBottomSheet.show(
                  label: AppStrings.selectAgeGroup.tr,
                  widget: AgeGroupView(
                    data: state.ages,
                    initialValue: initialValue?.id,
                    onSelect: (v) {
                      onSelect?.call(v);
                    },
                  ),
                  onConfirm: () => CustomNavigator.pop(),
                );
              } else if (state is AgeLoading) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.loading.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
              } else if (state is AgeEmpty) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.no_data.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
              } else if (state is AgeError) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.somethingWentWrong,
                    backgroundColor: AppColors.RED_CHART_COLOR,
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
