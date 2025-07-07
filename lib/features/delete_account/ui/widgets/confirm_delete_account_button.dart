import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../../core/utils/widgets/dialogs/custom_simple_dialog.dart';
import '../../logic/delete_account_cubit.dart';
import '../../logic/delete_account_state.dart';
import 'delete_account_fail_dialog.dart';
import 'delete_account_success_dialog.dart';

class ConfirmDeleteAccountButton extends StatelessWidget {
  const ConfirmDeleteAccountButton({
    super.key,
    this.height,
    this.width,
    this.borderRadiusValue,
    this.fontSize,
  });
  final double? height;
  final double? width;
  final double? borderRadiusValue;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
      listenWhen: (previous, current) =>
          current is DeleteAccountError || current is DeleteAccountSuccess,
      listener: (context, state) {
        if (state is DeleteAccountError) {
          CustomSimpleDialog.parentSimpleDialog(
            isDismissible: false,
            customListWidget: DeleteAccountFailDialog(
              error: state.error.message,
            ),
          );
        }
        if (state is DeleteAccountSuccess) {
          FocusScope.of(context).unfocus();
          CustomSimpleDialog.parentSimpleDialog(
            isDismissible: false,
            customListWidget: const DeleteAccountSuccessDialog(),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<DeleteAccountCubit>();
        return DefaultButton(
          isLoading: state is DeleteAccountLoading,
          text: AppStrings.confirm.tr,
          onPressed: () {
            if (cubit.formKey.currentState!.validate()) {
              FocusScope.of(context).unfocus();
              cubit.deleteAccountStatesHandled();
            }
          },
          height: height,
          width: width,
          borderRadiusValue: borderRadiusValue,
          fontSize: fontSize,
        );
      },
    );
  }
}
