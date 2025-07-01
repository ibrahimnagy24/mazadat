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
import '../../logic/bank_cubit.dart';
import '../widgets/banks_view.dart';

class BankInput extends StatelessWidget {
  const BankInput({super.key, this.initialValue, this.onSelect});
  final BankEntity? initialValue;
  final Function(BankEntity)? onSelect;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BankCubit()..citiesStatesHandled(),
      child: BlocBuilder<BankCubit, BankState>(
        buildWhen: (previous, current) =>
            current is BankLoading || current is BankDone || current is BankError,
        builder: (context, state) {
          final cubit = context.read<BankCubit>();
          return DefaultFormField(
            titleText: AppStrings.bank.tr,
            hintText: '${AppStrings.selectBank.tr}...',
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
              if (state is BankDone) {
                CustomBottomSheet.show(
                  label: AppStrings.selectBank.tr,
                  widget: BanksView(
                    data: state.ages,
                    initialValue: initialValue?.id,
                    onSelect: (v) {
                      onSelect?.call(v);
                    },
                  ),
                );
              } else if (state is BankLoading) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.loading.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
              } else if (state is BankEmpty) {
                AppCore.showSnackBar(
                  notification: AppNotification(
                    message: AppStrings.no_data.tr,
                    backgroundColor: AppColors.ALERT_COLOR,
                    borderColor: Colors.transparent,
                  ),
                );
              } else if (state is BankError) {
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
