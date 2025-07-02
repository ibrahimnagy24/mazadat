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
import '../../logic/forget_password_cubit.dart';
import '../../logic/forget_password_state.dart';

class ForgetPasswordButtonWidget extends StatelessWidget {
  const ForgetPasswordButtonWidget({
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
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listenWhen: (previous, current) =>
          current is ForgetPasswordError || current is ForgetPasswordSuccess,
      listener: (context, state) {
        final cubit = context.read<ForgetPasswordCubit>();
        if (state is ForgetPasswordError) {
          showErrorSnackBar(state.error.message);
        }
        if (state is ForgetPasswordSuccess) {
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
          current is ForgetPasswordLoading ||
          current is ForgetPasswordSuccess ||
          current is ForgetPasswordError,
      builder: (context, state) {
        final cubit = context.read<ForgetPasswordCubit>();
        return DefaultButton(
          isLoading: state is ForgetPasswordLoading,
          text: AppStrings.next.tr,
          onPressed: () {
            if (cubit.isResetValidate()) {
              FocusScope.of(context).unfocus();
              cubit.forgetPasswordStatesHandled();
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
