import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../user/user_data/logic/user_cubit.dart';
import '../../../user/user_data/logic/user_state.dart';
import 'profile_details_info.dart';

class BankInfoDetails extends StatelessWidget {
  const BankInfoDetails({super.key});

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
                  AppStrings.bankInfo.tr,
                  style: AppTextStyles.textLgBold
                      .copyWith(color: AppColors.mainDark),
                ),
              ),
              TextButton(
                onPressed: () {},
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
                  title: AppStrings.bankNumber.tr,
                  value: cubit.userEntity?.bankNumber ?? '----------------',
                  icon: AppSvg.invoice,
                ),
                ProfileDetailsInfo(
                  title: AppStrings.ibanNumber.tr,
                  value: cubit.userEntity?.ibanNumber ?? '----------------',
                  icon: AppSvg.bank,
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
