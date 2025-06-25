import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/form_fields/default_email_form_field.dart';
import '../../../../../core/utils/widgets/form_fields/default_phone_form_field.dart';
import '../../../../../core/utils/widgets/form_fields/default_username_form_field.dart';
import '../../logic/register_cubit.dart';
import '../../logic/register_state.dart';

class RegisterFieldStep1 extends StatelessWidget {
  const RegisterFieldStep1({super.key});

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
                Expanded(
                  child: DefaultUsernameFormField(
                    controller: context.read<RegisterCubit>().firstName,
                    readonly: isLoading,
                    titleText: AppStrings.firstName.tr,
                    hintText: AppStrings.enterFirstName.tr,
                  ),
                ),
                Expanded(
                  child: DefaultUsernameFormField(
                    controller: context.read<RegisterCubit>().lastName,
                    titleText: AppStrings.lastName.tr,
                    hintText: AppStrings.enterLastName.tr,
                    readonly: isLoading,
                  ),
                ),
              ],
            ),
            DefaultPhoneFormField(
              controller: context.read<RegisterCubit>().phone,
              readOnly: isLoading,
            ),
            DefaultEmailFormField(
              controller: context.read<RegisterCubit>().email,
              readOnly: isLoading,
            ),
          ],
        );
      },
    );
  }
}
