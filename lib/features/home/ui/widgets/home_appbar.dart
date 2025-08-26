import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
              gradient: LinearGradient(
                colors: AppColors.kAppBarGradient,
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
                      children: [
                        GestureDetector(
                          onTap: () {
                            CustomNavigator.push(Routes.MORE);
                          },
                          child: SvgPicture.asset(
                            AppSvg.menu,
                            height: 28,
                            width: 28,
                          ),
                        ),
                        const SizedBox(width: 24),
                        GestureDetector(
                          onTap: () {
                            // CustomNavigator.push(Routes.no);
                          },
                          child: SvgPicture.asset(
                            AppSvg.notification,
                            height: 28,
                            width: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SvgPicture.asset(
                      AppSvg.logo,
                      height: 56,
                      width: 78,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            CustomNavigator.push(Routes.PROFILE);
                          },
                          child: SvgPicture.asset(
                            AppSvg.user,
                            height: 28,
                            width: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(76);
}
