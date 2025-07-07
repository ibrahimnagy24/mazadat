import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../user/user_data/logic/user_cubit.dart';
import '../../../user/user_data/logic/user_state.dart';
import '../widgets/bank_info_details.dart';
import '../widgets/personal_info_details.dart';
import '../widgets/profile_header.dart';

class ProfileMobileDesign extends StatefulWidget {
  const ProfileMobileDesign({super.key});

  @override
  State<ProfileMobileDesign> createState() => _ProfileMobileDesignState();
}

class _ProfileMobileDesignState extends State<ProfileMobileDesign> {
  @override
  void initState() {
    context.read<UserCubit>().getUserDataStatesHandled();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      needAppbar: false,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
          final cubit = context.read<UserCubit>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ProfileHeader(),
              Expanded(
                child: Transform.translate(
                  offset: const Offset(0, -20),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Transform.translate(
                            offset: const Offset(0, -50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 4.h,
                              children: [
                                customContainerSvgIcon(
                                    imageName: AppSvg.user,
                                    width: 100.w,
                                    height: 100.w,
                                    radius: 100.w,
                                    padding: 20.w,
                                    color: AppColors.kPrimary,
                                    backGround: AppColors.backgroundBody),
                                Text(
                                  cubit.userEntity?.firstName ?? 'Name',
                                  style: AppTextStyles.textXLMedium,
                                ),
                                if (cubit.userEntity?.isSeller == true &&
                                    cubit.userEntity?.commericalNumber != null)
                                  Text(
                                    '${AppStrings.commercialNumber.tr} ${cubit.userEntity?.commericalNumber}',
                                    style: AppTextStyles.textXLMedium.copyWith(
                                        color:
                                            AppColors.textSecondaryParagraph),
                                  ),
                              ],
                            ),
                          ),
                          const PersonalInfoDetails(),
                          16.sbH,
                          // if (cubit.userEntity?.isSeller == true)
                          const BankInfoDetails(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
