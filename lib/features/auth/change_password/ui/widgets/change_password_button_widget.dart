import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_core.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../../core/utils/widgets/dialogs/custom_simple_dialog.dart';
import '../../logic/change_password_cubit.dart';
import '../../logic/change_password_state.dart';
import 'change_password_success_dialog.dart';

class ChangePasswordButtonWidget extends StatelessWidget {
  const ChangePasswordButtonWidget({
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
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listenWhen: (previous, current) =>
          current is ChangePasswordError || current is ChangePasswordSuccess,
      listener: (context, state) {
        if (state is ChangePasswordError) {
          showErrorSnackBar(state.error.message);
        }
        if (state is ChangePasswordSuccess) {
          FocusScope.of(context).unfocus();
          CustomSimpleDialog.parentSimpleDialog(
            isDismissible: false,
            customListWidget: const ChangePasswordSuccessDialog(),
          );
        }
      },
      buildWhen: (previous, current) =>
          current is ResetPasswordLoading ||
          current is ChangePasswordSuccess ||
          current is ChangePasswordError,
      builder: (context, state) {
        final cubit = context.read<ChangePasswordCubit>();
        return DefaultButton(
          isLoading: state is ResetPasswordLoading,
          text: AppStrings.save.tr,
          onPressed: () {
            if (cubit.formKey.currentState!.validate()) {
              FocusScope.of(context).unfocus();
              cubit.resetPasswordStatesHandled();
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
