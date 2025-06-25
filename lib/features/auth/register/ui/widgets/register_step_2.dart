import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/validations/validator.dart';
import '../../../../../core/utils/widgets/form_fields/default_password_form_field.dart';
import '../../../../selectors/age/ui/page/age_input.dart';
import '../../../../selectors/city/ui/page/city_input.dart';
import '../../logic/register_cubit.dart';
import '../../logic/register_state.dart';
import 'gender_input.dart';

class RegisterFieldStep2 extends StatelessWidget {
  const RegisterFieldStep2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final isLoading = state is RegisterLoading;
        return Column(
          spacing: 16.h,
          children: [
            Row(
              spacing: 8.w,
              children: [
                ///Age
                Expanded(
                  child: StreamBuilder(
                      stream: context.read<RegisterCubit>().ageStream,
                      builder: (context, asyncSnapshot) {
                        return AgeInput(
                          initialValue:
                              context.read<RegisterCubit>().age.valueOrNull,
                          onSelect: context.read<RegisterCubit>().updateAge,
                        );
                      }),
                ),

                ///Gender
                Expanded(
                  child: StreamBuilder(
                      stream: context.read<RegisterCubit>().genderStream,
                      builder: (context, asyncSnapshot) {
                        return GenderInput(
                          initialValue: context.read<RegisterCubit>().gender.valueOrNull,
                          onSelect: context.read<RegisterCubit>().updateGender,
                        );
                      }),
                ),
              ],
            ),

            ///City
            StreamBuilder(
                stream: context.read<RegisterCubit>().cityStream,
                builder: (context, asyncSnapshot) {
                  return CityInput(
                    initialValue:
                        context.read<RegisterCubit>().city.valueOrNull,
                    onSelect: context.read<RegisterCubit>().updateCity,
                  );
                }),
            DefaultPasswordFormField(
              controller: context.read<RegisterCubit>().password,
              readOnly: isLoading,
              needPasswordStrength: true,
            ),
            DefaultPasswordFormField(
              controller: context.read<RegisterCubit>().confirmPassword,
              titleText: AppStrings.confirmNewPassword.tr,
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
