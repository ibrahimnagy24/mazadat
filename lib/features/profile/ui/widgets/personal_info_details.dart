import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../user/logic/user_cubit.dart';
import '../../../user/logic/user_state.dart';
import 'profile_details_info.dart';

class PersonalInfoDetails extends StatelessWidget {
  const PersonalInfoDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      final cubit = context.read<UserCubit>();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.personalInfo.tr,
                  style: AppTextStyles.textLgBold
                      .copyWith(color: AppColors.mainDark),
                ),
              ),
              TextButton(
                onPressed: () => CustomNavigator.push(Routes.EDIT_PROFILE),
                child: Row(
                  spacing: 4.w,
                  children: [
                    Text(
                      AppStrings.edit.tr,
                      style: AppTextStyles.textMdSemibold,
                      textAlign: TextAlign.start,
                    ),
                    customImageIconSVG(
                      imageName: AppSvg.edit,
                      width: 16.w,
                      height: 16.w,
                      color: AppColors.kPrimary,
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(AppRadius.rLg.w),
            ),
            child: Column(
              children: [
                ProfileDetailsInfo(
                  title: AppStrings.userName.tr,
                  value: cubit.userEntity?.firstName,
                  icon: AppSvg.user,
                ),
                ProfileDetailsInfo(
                  title: AppStrings.gender.tr,
                  value: cubit.userEntity?.gender.name.tr,
                  icon: AppSvg.userGender,
                ),
                ProfileDetailsInfo(
                  title: AppStrings.city.tr,
                  value: cubit.userEntity?.city?.name,
                  icon: AppSvg.city,
                ),
                ProfileDetailsInfo(
                  title: AppStrings.age.tr,
                  value: cubit.userEntity?.age?.name,
                  icon: AppSvg.calendar,
                ),
                ProfileDetailsInfo(
                  title: AppStrings.mobileNumber.tr,
                  value: cubit.userEntity?.completePhone,
                  icon: AppSvg.phone,
                  // action: TextButton(
                  //   onPressed: () => CustomNavigator.push(
                  //       Routes.CHANGE_PHONE_NUMBER_SCREEN,
                  //       extra: cubit.userEntity?.phone),
                  //   child: Row(
                  //     spacing: 4.w,
                  //     children: [
                  //       Text(
                  //         AppStrings.edit.tr,
                  //         style: AppTextStyles.textMdSemibold,
                  //         textAlign: TextAlign.start,
                  //       ),
                  //       customImageIconSVG(
                  //         imageName: AppSvg.edit,
                  //         width: 16.w,
                  //         height: 16.w,
                  //         color: AppColors.kPrimary,
                  //       )
                  //     ],
                  //   ),
                  // ),
                ),
                ProfileDetailsInfo(
                  title: AppStrings.theEmail.tr,
                  value: cubit.userEntity?.email,
                  icon: AppSvg.mail,
                ),
                ProfileDetailsInfo(
                  title: AppStrings.password.tr,
                  value: '********',
                  icon: AppSvg.lock,
                  action: TextButton(
                    onPressed: () =>
                        CustomNavigator.push(Routes.CHANGE_PASSWORD_SCREEN),
                    child: Row(
                      spacing: 4.w,
                      children: [
                        Text(
                          AppStrings.edit.tr,
                          style: AppTextStyles.textMdSemibold,
                          textAlign: TextAlign.start,
                        ),
                        customImageIconSVG(
                          imageName: AppSvg.edit,
                          width: 16.w,
                          height: 16.w,
                          color: AppColors.kPrimary,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 16.h,
                      children: [
                        customContainerSvgIcon(
                            imageName: AppSvg.favourite,
                            width: 40.w,
                            height: 40.w,
                            radius: 100.w,
                            padding: 10.w,
                            borderColor: AppColors.background,
                            backGround: AppColors.background,
                            color: AppColors.iconPrimary),
                        Expanded(
                          child: Text(AppStrings.favouriteCategories.tr,
                              textAlign: TextAlign.start,
                              style: AppTextStyles.textLgRegular),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                          color: AppColors.iconPrimary,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      );
    });
  }
}
