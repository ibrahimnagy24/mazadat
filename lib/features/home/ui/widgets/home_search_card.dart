import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/shared/widgets/custom_images.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../logic/home_cubit.dart';

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
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 12),
                      child: SvgPicture.asset(
                        AppSvg.filterIcon,
                        height: 20,
                        width: 20,
                        color: AppColors.textSecondaryParagraph,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          ///Listing Button
          StreamBuilder(
              stream: context.read<HomeCubit>().listingStream,
              builder: (c, snapshot) {
                return InkWell(
                  onTap: () => context
                      .read<HomeCubit>()
                      .updateListing(snapshot.data == true ? false : true),
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
                      snapshot.data == true ? AppSvg.grid : AppSvg.list,
                      width: 20,
                      height: 20,
                      color: AppColors.textSecondaryParagraph,
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
