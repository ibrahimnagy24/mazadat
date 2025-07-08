import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/validations/validator.dart';
import '../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../../selectors/banks/ui/page/bank_input.dart';
import '../../logic/edit_bank_details_cubit.dart';
import '../../logic/edit_bank_details_state.dart';

class EditBankDetailsBody extends StatelessWidget {
  const EditBankDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditBankDetailsCubit, EditBankDetailsState>(
      builder: (context, state) {
        final isLoading = state is EditBankDetailsLoading;
        return Expanded(
          child: ListAnimator(
            data: [
              ///Bank
              StreamBuilder(
                  stream: context.read<EditBankDetailsCubit>().bankStream,
                  builder: (context, asyncSnapshot) {
                    return BankInput(
                      initialValue:
                          context.read<EditBankDetailsCubit>().bank.valueOrNull,
                      onSelect: context.read<EditBankDetailsCubit>().updateBank,
                    );
                  }),
              16.sbH,

              DefaultFormField(
                controller: context.read<EditBankDetailsCubit>().bankNumber,
                readOnly: isLoading,
                titleText: AppStrings.bankNumber.tr,
                hintText: AppStrings.enterBankNumber.tr,
                validator: (v) => DefaultValidator.defaultValidator(
                  v,
                  label: AppStrings.bankNumber.tr,
                ),
              ),
              16.sbH,

              DefaultFormField(
                controller: context.read<EditBankDetailsCubit>().ibanNumber,
                readOnly: isLoading,
                titleText: AppStrings.ibanNumber.tr,
                hintText: AppStrings.enterIbanNumber.tr,
                validator: (v) => DefaultValidator.defaultValidator(
                  v,
                  label: AppStrings.ibanNumber.tr,
                ),
              ),
              16.sbH,

              DefaultFormField(
                controller:
                    context.read<EditBankDetailsCubit>().commercialNumber,
                readOnly: isLoading,
                titleText: AppStrings.commercialNumber.tr,
                hintText: AppStrings.enterCommercialNumber.tr,
                validator: (v) => DefaultValidator.defaultValidator(
                  v,
                  label: AppStrings.commercialNumber.tr,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
