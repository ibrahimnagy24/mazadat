import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app_core.dart';
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
import '../../logic/register_cubit.dart';
import '../../logic/register_state.dart';

class CreateAccountButtonWidget extends StatelessWidget {
  const CreateAccountButtonWidget({
    super.key,
    this.height,
    this.width,
    this.borderRadiousValue,
    this.fontSize,
    this.animationBorderRadius,
  });
  final double? height;
  final double? width;
  final double? borderRadiousValue;
  final double? fontSize;
  final double? animationBorderRadius;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
          current is RegisterError || current is RegisterSucess,
      listener: (context, state) {
        if (state is RegisterError) {
          ToastService.showCustom(
            message: state.error.message,
            context: context,
            toastStatusType: ToastStatusType.error,
            errorEntity: state.error,
          );
        }
        if (state is RegisterSucess) {
          FocusScope.of(context).unfocus();
          ToastService.showCustom(
            message: state.registerEntity.message,
            context: context,
            toastStatusType: ToastStatusType.success,
          );
          CustomNavigator.push(
            Routes.VERIFY_CODE_SCREEN,
            replace: true,
            extra: VerifyCodeRouteParams(
              phone: context.read<RegisterCubit>().phone.text,
              fromScreenEnum: VerifyCodeFromScreen.fromRegister,
              countryCode: AppConstant.countryCode,
            ),
          );
        }
      },
      buildWhen: (previous, current) =>
          current is RegisterLoading ||
          current is RegisterSucess ||
          current is RegisterError ||
          current is RegisterStepChanged,
      builder: (context, state) {
        final cubit = context.read<RegisterCubit>();
        return DefaultButton(
          isLoading: state is RegisterLoading,
          text: cubit.currentStep == 0
              ? AppStrings.next.tr
              : AppStrings.createANewAccount.tr,
          onPressed: () {
            if (cubit.currentStep == 0) {
              if (cubit.isStepOneValid()) {
                context.read<RegisterCubit>().updateStep(1);
              }
              return;
            }
            if (cubit.currentStep == 1) {
              if (!cubit.isAgreePolicyAndConditionsValid()) {
                ToastService.showCustom(
                  message: AppStrings.pleaseCheckTermsAndConditions.tr,
                  context: context,
                  toastStatusType: ToastStatusType.error,
                );
                return;
              }
              if (cubit.isStepTwoValid()) {
                FocusScope.of(context).unfocus();
                cubit.registerStatesHandled();
              }
              return;
            }
          },
          height: height,
          width: width,
          borderRadiusValue: borderRadiousValue,
          fontSize: fontSize,
          animationDuration: 1500.ms,
          textStyle: AppTextStyles.bodyXlBold.copyWith(color: Colors.white),
        );
      },
    );
  }
}
