import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/validations/vaildator.dart';
import '../../../../../core/utils/widgets/form_fields/default_email_form_field.dart';
import '../../../../../core/utils/widgets/form_fields/default_password_form_field.dart';
import '../../../../../core/utils/widgets/form_fields/default_phone_form_field.dart';
import '../../../../../core/utils/widgets/form_fields/default_username_form_field.dart';
import '../../logic/register_cubit.dart';
import '../../logic/register_state.dart';

class RegisterFormFieldWidget extends StatelessWidget {
  const RegisterFormFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final isLoading = state is RegisterLoading;
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DefaultUsernameFormField(
                    controller: context.read<RegisterCubit>().firstName,
                    readonly: isLoading,
                    hintText: AppStrings.example.tr,
                  ),
                ),
                8.sbW,
                Expanded(
                  child: DefaultUsernameFormField(
                    controller: context.read<RegisterCubit>().lastName,
                    titleText: AppStrings.lastName.tr,
                    hintText: AppStrings.example.tr,
                    readonly: isLoading,
                  ),
                ),
              ],
            ),
            16.sbH,
            DefaultPhoneFormField(
              controller: context.read<RegisterCubit>().phone,
              readOnly: isLoading,
            ),
            16.sbH,
            DefaultEmailFormField(
              controller: context.read<RegisterCubit>().email,
              readOnly: isLoading,
              needValidation:
                  context.read<RegisterCubit>().email.text.isNotEmpty,
            ),
            16.sbH,
            DefaultPasswordFormField(
              controller: context.read<RegisterCubit>().password,
              readOnly: isLoading,
              needPasswordStrength: true,
            ),
            16.sbH,
            DefaultPasswordFormField(
              controller: context.read<RegisterCubit>().confirmPassword,
              titleText: AppStrings.confirmNewPassword.tr,
              hintText: AppStrings.repeatPassword.tr,
              validator: (value) =>
                  PasswordConfirmationValidator.passwordValidator(
                context.read<RegisterCubit>().password.text,
                value,
              ),
              readOnly: isLoading,
            ),
          ],
        );
      },
    );
  }
}
