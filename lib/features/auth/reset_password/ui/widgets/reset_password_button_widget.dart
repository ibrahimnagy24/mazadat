import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_core.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';

import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/enums/enums.dart';

import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../verify_code/data/params/verify_code_route_params.dart';
import '../../logic/reset_password_cubit.dart';
import '../../logic/reset_password_state.dart';

class ResetPasswordButtonWidget extends StatelessWidget {
  const ResetPasswordButtonWidget({
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
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listenWhen: (previous, current) =>
          current is ResetPasswordError || current is ResetPasswordSucess,
      listener: (context, state) {
        final cubit = context.read<ResetPasswordCubit>();
        if (state is ResetPasswordError) {
          showErrorSnackBar(state.error.message);
        }
        if (state is ResetPasswordSucess) {
          CustomNavigator.push(
            Routes.VERIFY_CODE_SCREEN,
            replace: true,
            extra: VerifyCodeRouteParams(
              phone: cubit.phone.text,
              fromScreenEnum: VerifyCodeFromScreen.fromForgetPassword,
              countryCode: '966',
            ),
          );
        }
      },
      buildWhen: (previous, current) =>
          current is ResetPasswordLoading ||
          current is ResetPasswordSucess ||
          current is ResetPasswordError,
      builder: (context, state) {
        final cubit = context.read<ResetPasswordCubit>();
        return DefaultButton(
          isLoading: state is ResetPasswordLoading,
          text: AppStrings.next.tr,
          onPressed: () {
            if (cubit.isResetValidate()) {
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
