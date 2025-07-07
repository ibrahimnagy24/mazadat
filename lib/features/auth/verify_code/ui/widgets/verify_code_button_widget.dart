import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app_core.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/theme/text_styles/app_font_size_styles.dart';

import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/enums/enums.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../../core/utils/widgets/dialogs/custom_simple_dialog.dart'
    show CustomSimpleDialog;
import '../../../reset_password/data/params/reset_password_route_params.dart';
import '../../logic/verify_code_cubit.dart';
import '../../logic/verify_code_state.dart';
import 'register_success_dialog.dart';

class VerifyCodeButtonWidget extends StatelessWidget {
  const VerifyCodeButtonWidget({
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
    return BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
      listenWhen: (previous, current) =>
          current is VerifyCodeError || current is VerifyCodeSuccess,
      listener: (context, state) {
        final cubit = context.read<VerifyCodeCubit>();
        if (state is VerifyCodeError) {
          showErrorSnackBar(state.error.message);
        }
        if (state is VerifyCodeSuccess) {
          FocusScope.of(context).unfocus();
          // showSuccessToast(state.data.message);
          switch (cubit.resetPasswordParams.fromScreenEnum) {
            case VerifyCodeFromScreen.fromLogin:
              CustomNavigator.push(Routes.NAV_BAR_LAYOUT, clean: true);
              break;
            case VerifyCodeFromScreen.fromForgetPassword:
              CustomNavigator.push(
                Routes.RESET_PASSWORD_SCREEN,
                replace: true,
                extra: ResetPasswordRouteParams(
                    phone: cubit.resetPasswordParams.phone,
                    otp: cubit.code.text.trim()),
              );
              break;
            case VerifyCodeFromScreen.fromRegister:
              CustomSimpleDialog.parentSimpleDialog(
                customListWidget: const RegisterSuccessDialog(),
              );
              break;
            case VerifyCodeFromScreen.fromChangePhoneNumber:
              CustomSimpleDialog.parentSimpleDialog(
                customListWidget: const RegisterSuccessDialog(
                  fromRegister: false,
                ),
              );
              break;
          }
        }
      },
      buildWhen: (previous, current) =>
          current is VerifyCodeLoading ||
          current is VerifyCodeSuccess ||
          current is VerifyCodeError,
      builder: (context, state) {
        final cubit = context.read<VerifyCodeCubit>();
        return DefaultButton(
          isLoading: state is VerifyCodeLoading,
          text: AppStrings.next.tr,
          onPressed: () {
            if (cubit.isResetValidate()) {
              FocusScope.of(context).unfocus();
              cubit.verifyCodeStatesHandled();
            }
          },
          height: height,
          width: width,
          borderRadiusValue: borderRadiusValue,
          fontSize: fontSize ?? AppFontSizes.fsM,
          fontWeight: FontWeight.w500,
        );
      },
    );
  }
}
