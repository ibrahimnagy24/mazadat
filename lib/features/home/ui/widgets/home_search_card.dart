import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../data/enum/displayed_types.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';

class HomeSearchCard extends StatelessWidget {
  const HomeSearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => CustomNavigator.push(Routes.SEARCH),
              child: Container(
                height: 53,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.5),
                  border: Border.all(color: AppColors.borderNeutralSecondary),
                  borderRadius: BorderRadius.circular(AppRadius.rMd),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 12,
                        end: 8,
                      ),
                      child: SvgPicture.asset(
                        AppSvg.searchIcon,
                        width: 20,
                        height: 20,
                        color: AppColors.textSecondaryParagraph,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        AppStrings.lookingForAuctions.tr,
                        style: AppTextStyles.textLgRegular
                            .copyWith(color: AppColors.textSecondaryParagraph),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsetsDirectional.only(end: 12),
                    //   child: SvgPicture.asset(
                    //     AppSvg.filterIcon,
                    //     height: 20,
                    //     width: 20,
                    //     color: AppColors.textSecondaryParagraph,
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) =>
                current is HomeDisplayedTypeChanged,
            builder: (context, state) {
              final cubit = context.read<HomeCubit>();
              return InkWell(
                onTap: () => cubit.updateOrToggleDisplayedType(),
                child: Container(
                  height: 53,
                  width: 53,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                    border: Border.all(
                      color: AppColors.borderNeutralSecondary,
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.rMd),
                  ),
                  child: SvgPicture.asset(
                    cubit.displayedType == HomeDisplayedTypes.grid
                        ? AppSvg.grid
                        : AppSvg.list,
                    width: 20,
                    height: 20,
                    color: AppColors.textSecondaryParagraph,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
