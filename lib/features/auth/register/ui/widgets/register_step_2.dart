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
import '../../../../../core/shared/widgets/gender_input.dart';

class RegisterFieldStep2 extends StatelessWidget {
  const RegisterFieldStep2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => current is RebuildInputs,
      builder: (context, state) {
        final isLoading = state is RegisterLoading;
        final cubit = context.read<RegisterCubit>();
        return Form(
          key: cubit.stepTwoFormKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: AgeInput(
                      initialValue: context.read<RegisterCubit>().ageController,
                      onSelect: (selected) {
                        context.read<RegisterCubit>().ageController = selected;
                        cubit.rebuildInputs();
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GenderInput(
                      initialValue:
                          context.read<RegisterCubit>().genderController,
                      onSelect: (selected) {
                        context.read<RegisterCubit>().genderController =
                            selected;
                        cubit.rebuildInputs();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CityInput(
                initialValue: context.read<RegisterCubit>().cityEntity,
                onSelect: (selected) {
                  context.read<RegisterCubit>().cityEntity = selected;
                  cubit.rebuildInputs();
                },
              ),
              const SizedBox(height: 16),
              DefaultPasswordFormField(
                controller: context.read<RegisterCubit>().password,
                readOnly: isLoading,
                needPasswordStrength: true,
              ),
              const SizedBox(height: 16),
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
          ),
        );
      },
    );
  }
}
