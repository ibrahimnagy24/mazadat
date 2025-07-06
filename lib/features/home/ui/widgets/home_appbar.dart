import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppRadius.rLg.w),
                bottomRight: Radius.circular(AppRadius.rLg.w),
              ),
              gradient: LinearGradient(
                colors: AppColors.kAppBarGradient,
                stops: const [0.08, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      spacing: 24.w,
                      children: [
                        customImageIconSVG(
                            onTap: () {},
                            imageName: AppSvg.menu,
                            width: 24.w,
                            height: 24.w,
                            color: AppColors.iconSecondary),
                        customImageIconSVG(
                            onTap: () {},
                            imageName: AppSvg.notification,
                            width: 24.w,
                            height: 24.w,
                            color: AppColors.iconSecondary),
                      ],
                    ),
                  ),
                  Expanded(
                    child: customImageIconSVG(
                      imageName: AppSvg.logo,
                      height: 55.h,
                      width: 80.w,
                    ),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      customImageIconSVG(
                          onTap: () {},
                          imageName: AppSvg.user,
                          width: 24.w,
                          height: 24.w,
                          color: AppColors.iconSecondary),
                    ],
                  )),
                ],
              ),
            ));
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100.h);
}
