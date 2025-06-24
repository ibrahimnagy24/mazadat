import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_core.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/utils/widgets/buttons/custom_gradient_button_widget.dart';
import '../../logic/change_password_cubit.dart';
import '../../logic/change_password_state.dart';

class ChangePasswordButtonWidget extends StatelessWidget {
  const ChangePasswordButtonWidget({
    super.key,
    this.height,
    this.width,
    this.borderRadiousValue,
    this.fontSize,
  });
  final double? height;
  final double? width;
  final double? borderRadiousValue;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listenWhen: (previous, current) =>
          current is ChangePasswordError || current is ChangePasswordSucess,
      listener: (context, state) {
        if (state is ChangePasswordError) {
          showErrorSnackBar(state.error.message);
        }
        if (state is ChangePasswordSucess) {
          FocusScope.of(context).unfocus();
          showSuccessToast(state.data.message);

          CustomNavigator.push(
            Routes.CHANGE_PASSWORD_SUCCESS_SCREEN,
            replace: true,
          );
        }
      },
      buildWhen: (previous, current) =>
          current is ChangePasswordLoading ||
          current is ChangePasswordSucess ||
          current is ChangePasswordError,
      builder: (context, state) {
        final cubit = context.read<ChangePasswordCubit>();
        return CustomGradientButtonWidget(
          isLoading: state is ChangePasswordLoading,
          text: ' AppStrings.resetPassword.tr',
          onPressed: () {
            if (cubit.isNewPasswordValid()) {
              FocusScope.of(context).unfocus();
              cubit.changePasswordStatesHandled();
            }
          },
          height: height,
          width: width,
          borderRadiousValue: borderRadiousValue,
          fontSize: fontSize,
        );
      },
    );
  }
}
