import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app_core.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../core/utils/widgets/dialogs/custom_simple_dialog.dart';
import '../../logic/edit_bank_details_cubit.dart';
import '../../logic/edit_bank_details_state.dart';
import 'update_bank_details_success_dialog.dart';

class EditBankDetailsButton extends StatelessWidget {
  const EditBankDetailsButton({
    super.key,
    this.height,
    this.width,
    this.borderRadiusValue,
    this.fontSize,
    this.animationBorderRadius,
  });
  final double? height;
  final double? width;
  final double? borderRadiusValue;
  final double? fontSize;
  final double? animationBorderRadius;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditBankDetailsCubit, EditBankDetailsState>(
      listenWhen: (previous, current) =>
          current is EditBankDetailsError || current is EditBankDetailsSuccess,
      listener: (context, state) {
        if (state is EditBankDetailsError) {
          showErrorSnackBar(state.error.message, error: state.error);
        }
        if (state is EditBankDetailsSuccess) {
          FocusScope.of(context).unfocus();
          CustomSimpleDialog.parentSimpleDialog(
            isDismissible: false,
            customListWidget: const UpdateBankDetailsSuccessDialog(),
          );
        }
      },
      buildWhen: (previous, current) =>
          current is EditBankDetailsLoading ||
          current is EditBankDetailsSuccess ||
          current is EditBankDetailsError,
      builder: (context, state) {
        final cubit = context.read<EditBankDetailsCubit>();
        return DefaultButton(
          isLoading: state is EditBankDetailsLoading,
          text: AppStrings.save.tr,
          onPressed: () {
            if (cubit.isRegisterValidate()) {
              FocusScope.of(context).unfocus();
              cubit.editProfileStatesHandled();
            }
          },
          height: height,
          width: width,
          borderRadiusValue: borderRadiusValue,
          fontSize: fontSize,
          animationDuration: 1500.ms,
        );
      },
    );
  }
}
