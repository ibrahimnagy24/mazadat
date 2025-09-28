import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/form_fields/default_email_form_field.dart';
import '../../../../../core/utils/widgets/form_fields/default_phone_form_field.dart';
import '../../../../../core/utils/widgets/form_fields/default_username_form_field.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/validations/validator.dart';
import '../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../../../core/shared/widgets/gender_input.dart';
import '../../../auth/change_phone_number/data/params/change_phone_number_route_params.dart';
import '../../../selectors/age/ui/page/age_input.dart';
import '../../../address/city/ui/page/city_input.dart';
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
                            initialValue: context
                                .read<EditProfileCubit>()
                                .age
                                .valueOrNull,
                            onSelect:
                                context.read<EditProfileCubit>().updateAge,
                            validator: (v) => DefaultValidator.defaultValidator(
                              asyncSnapshot.data?.name ?? '',
                              label: AppStrings.age.tr,
                            ),
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
                            validator: (v) => DefaultValidator.defaultValidator(
                              asyncSnapshot.data?.name ?? '',
                              label: AppStrings.gender.tr,
                            ),
                          );
                        }),
                  ),
                ],
              ),
              16.sbH,

              // /City
              StreamBuilder(
                  stream: context.read<EditProfileCubit>().cityStream,
                  builder: (context, asyncSnapshot) {
                    return CityInput(
                      initialValue:
                          context.read<EditProfileCubit>().city.valueOrNull,
                      onSelect: context.read<EditProfileCubit>().updateCity,
                      validator: (v) => DefaultValidator.defaultValidator(
                        asyncSnapshot.data?.name ?? '',
                        label: AppStrings.city.tr,
                      ),
                      loadAllCities: true,
                    );
                  }),
              16.sbH,

              ///Phone
              DefaultPhoneFormField(
                controller: context.read<EditProfileCubit>().phone,
                readOnly: true,
                suffixWidget: IconButton(
                  onPressed: () => CustomNavigator.push(
                    Routes.CHANGE_PHONE_NUMBER_SCREEN,
                    extra: ChangePhoneNumberRouteParams(
                      oldPhone:
                          context.read<EditProfileCubit>().phone.text.trim(),
                    ),
                  ),
                  icon: SvgPicture.asset(
                    AppSvg.edit,
                    width: 16,
                    height: 16,
                    color: AppColors.kPrimary,
                  ),
                ),
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
