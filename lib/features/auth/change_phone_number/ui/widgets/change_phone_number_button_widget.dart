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
import '../../logic/change_phone_number_cubit.dart';
import '../../logic/change_phone_number_state.dart';

class ChangePhoneButtonWidget extends StatelessWidget {
  const ChangePhoneButtonWidget({
    super.key,
    this.height,
    this.width,
    this.borderRadiusValue,
    this.fontSize,
    required this.oldPhone,
  });
  final double? height;
  final double? width;
  final double? borderRadiusValue;
  final double? fontSize;
  final String oldPhone;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePhoneNumberCubit, ChangePhoneNumberState>(
      listenWhen: (previous, current) =>
          current is ChangePhoneNumberError ||
          current is ChangePHoneNumberSuccess,
      listener: (context, state) {
        final cubit = context.read<ChangePhoneNumberCubit>();
        if (state is ChangePhoneNumberError) {
          showErrorSnackBar(state.error.message);
        }
        if (state is ChangePHoneNumberSuccess) {
          CustomNavigator.push(
            Routes.VERIFY_CODE_SCREEN,
            replace: true,
            extra: VerifyCodeRouteParams(
              phone: cubit.phone.text,
              fromScreenEnum: VerifyCodeFromScreen.fromChangePhoneNumber,
              countryCode: '966',
            ),
          );
        }
      },
      buildWhen: (previous, current) =>
          current is ChangePhoneNumberLoading ||
          current is ChangePHoneNumberSuccess ||
          current is ChangePhoneNumberError,
      builder: (context, state) {
        final cubit = context.read<ChangePhoneNumberCubit>();
        return DefaultButton(
          isLoading: state is ChangePhoneNumberLoading,
          text: AppStrings.next.tr,
          onPressed: () {
            if (cubit.isResetValidate()) {
              FocusScope.of(context).unfocus();
              cubit.changePhoneNumberStatesHandled(oldPhone);
            }
          },
        );
      },
    );
  }
}
