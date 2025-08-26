import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';

import '../../../../../core/services/toast_service.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_constant.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/enums/enums.dart';

import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../verify_code/data/params/verify_code_route_params.dart';
import '../../logic/login_cubit.dart';
import '../../logic/login_state.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({
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
    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          current is LoginError || current is LoginSuccess,
      listener: (context, state) {
        if (state is LoginError) {
          ToastService.showCustom(
            message: state.error.message,
            context: context,
            toastStatusType: ToastStatusType.error,
            errorEntity: state.error,
          );

          if (state.error.message == 'INACTIVE_ACCOUNT') {
            CustomNavigator.push(
              Routes.VERIFY_CODE_SCREEN,
              extra: VerifyCodeRouteParams(
                phone: context.read<LoginCubit>().phone.text,
                fromScreenEnum: VerifyCodeFromScreen.fromLogin,
                countryCode: AppConstant.countryCode,
              ),
            );
          }
        }
        if (state is LoginSuccess) {
          FocusScope.of(context).unfocus();

          if (state.loginEntity.userStatus == UserStatus.active) {
            CustomNavigator.push(Routes.NAV_BAR_LAYOUT, clean: true);
          } else {
            ToastService.showCustom(
              message: 'account is not active',
              context: context,
              toastStatusType: ToastStatusType.warning,
            );
          }
        }
      },
      buildWhen: (previous, current) =>
          current is LoginLoading ||
          current is LoginSuccess ||
          current is LoginError,
      builder: (context, state) {
        final cubit = context.read<LoginCubit>();
        return DefaultButton(
          isLoading: state is LoginLoading,
          text: AppStrings.login.tr,
          onPressed: () {
            if (cubit.isLoginValidate()) {
              FocusScope.of(context).unfocus();
              cubit.loginStatesHandled();
            }
          },
          height: height,
          width: width,
          borderRadiusValue: borderRadiousValue,
          fontSize: fontSize,
          textStyle: AppTextStyles.bodyXlBold
              .copyWith(color: const Color.fromRGBO(255, 255, 255, 1)),
        );
      },
    );
  }
}
