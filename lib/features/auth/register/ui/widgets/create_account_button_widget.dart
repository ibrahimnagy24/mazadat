import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app_core.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
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
          showErrorSnackBar(state.error.message, error: state.error);
        }
        if (state is RegisterSucess) {
          FocusScope.of(context).unfocus();
          CustomNavigator.push(
            Routes.VERIFY_CODE_SCREEN,
            replace: true,
            extra: VerifyCodeRouteParams(
              phone: context.read<RegisterCubit>().phone.text,
              fromScreenEnum: VerifyCodeFromScreen.fromRegister,
              countryCode: '966',
            ),
          );
          showSuccessToast(state.registerEntity.message);
        }
      },
      buildWhen: (previous, current) =>
          current is RegisterLoading ||
          current is RegisterSucess ||
          current is RegisterError,
      builder: (context, state) {
        final cubit = context.read<RegisterCubit>();
        return DefaultButton(
          isLoading: state is RegisterLoading,
          text: AppStrings.createANewAccount.tr,
          onPressed: () {
            if (cubit.isRegisterValidate()) {
              FocusScope.of(context).unfocus();
              cubit.registerStatesHandled();
            }
          },
          // onPressed: fromChooseCategoryScreen
          //     ? () {
          //         if (cubit.isRegisterValidate(fromChooseCategoryScreen)) {
          //           FocusScope.of(context).unfocus();
          //           cubit.registerStatesHandled();
          //         }
          //       }
          //     : () {
          //         if (cubit.isRegisterValidate(fromChooseCategoryScreen)) {
          //           CustomNavigator.push(
          //             Routes.CHOOSE_FAV_CATEGORY,
          //             arguments: ChooseFavCategoryParams(cubit: cubit),
          //           );
          //         }
          //       },
          height: height,
          width: width,
          borderRadiusValue: borderRadiousValue,
          fontSize: fontSize,
          // animationBorderRadious: animationBorderRadious ?? 24.r,
          animationDuration: 1500.ms,
        );
      },
    );
  }
}
