import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/form_fields/default_email_form_field.dart';
import '../../../../../core/utils/widgets/form_fields/default_phone_form_field.dart';
import '../../../../../core/utils/widgets/form_fields/default_username_form_field.dart';
import '../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../auth/register/ui/widgets/gender_input.dart';
import '../../../selectors/age/ui/page/age_input.dart';
import '../../../selectors/city/ui/page/city_input.dart';
import '../../logic/edit_profile_cubit.dart';
import '../../logic/edit_profile_state.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        final isLoading = state is EditProfileLoading;
        return Expanded(
          child: ListAnimator(
            data: [
              ///Name
              Row(
                spacing: 8.w,
                children: [
                  Expanded(
                    child: DefaultUsernameFormField(
                      controller: context.read<EditProfileCubit>().firstName,
                      readonly: isLoading,
                      titleText: AppStrings.firstName.tr,
                      hintText: AppStrings.enterFirstName.tr,
                    ),
                  ),
                  Expanded(
                    child: DefaultUsernameFormField(
                      controller: context.read<EditProfileCubit>().lastName,
                      titleText: AppStrings.lastName.tr,
                      hintText: AppStrings.enterLastName.tr,
                      readonly: isLoading,
                    ),
                  ),
                ],
              ),
              16.sbH,

              ///Age & Gender
              Row(
                spacing: 8.w,
                children: [
                  ///Age
                  Expanded(
                    child: StreamBuilder(
                        stream: context.read<EditProfileCubit>().ageStream,
                        builder: (context, asyncSnapshot) {
                          return AgeInput(
                            initialValue:
                                context.read<EditProfileCubit>().age.valueOrNull,
                            onSelect: context.read<EditProfileCubit>().updateAge,
                          );
                        }),
                  ),

                  ///Gender
                  Expanded(
                    child: StreamBuilder(
                        stream: context.read<EditProfileCubit>().genderStream,
                        builder: (context, asyncSnapshot) {
                          return GenderInput(
                            initialValue: context
                                .read<EditProfileCubit>()
                                .gender
                                .valueOrNull,
                            onSelect:
                                context.read<EditProfileCubit>().updateGender,
                          );
                        }),
                  ),
                ],
              ),
              16.sbH,

              ///City
              StreamBuilder(
                  stream: context.read<EditProfileCubit>().cityStream,
                  builder: (context, asyncSnapshot) {
                    return CityInput(
                      initialValue:
                          context.read<EditProfileCubit>().city.valueOrNull,
                      onSelect: context.read<EditProfileCubit>().updateCity,
                    );
                  }),
              16.sbH,

              ///Phone
              DefaultPhoneFormField(
                controller: context.read<EditProfileCubit>().phone,
                readOnly: true,
              ),
              16.sbH,

              ///Email
              DefaultEmailFormField(
                controller: context.read<EditProfileCubit>().email,
                readOnly: isLoading,
              ),
            ],
          ),
        );
      },
    );
  }
}
