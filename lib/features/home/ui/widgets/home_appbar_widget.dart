import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/widgets/category_widget.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radiuos/app_radiuos.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/empty/empty_widget.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/form_fields/default_search_form_field.dart';
import '../../../../core/utils/widgets/loading/adaptive_cirluer_progress.dart';
import '../../../../core/utils/widgets/text/main_text.dart';
import '../../../auth/choose_category/logic/category_cubit.dart';
import '../../data/enums/home_enums.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';

class HomeAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbarWidget({super.key, this.height = 305});
  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is HomeTitleTypeChanged,
      builder: (context, state) {
        final homeTitleType = context.read<HomeCubit>().getHomeTitleType;
        final showDepartments = homeTitleType == HomeTitleType.auction;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutQuad,
          height: height,
          child: SafeArea(
            child: ClipRect(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: OverflowBox(
                  maxHeight: 370,
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const _HomeTitleWidget(),
                      const SizedBox(height: 16),
                      const DefaultSearchFormField(),
                      const SizedBox(height: 16),
                      const _HomeAuctionOrBundleTaps(),
                      // Use AnimatedOpacity and AnimatedContainer for smoother transitions
                      AnimatedOpacity(
                        opacity: showDepartments ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOutQuad,
                          height: showDepartments ? null : 0,
                          child: Visibility(
                            visible: showDepartments,
                            maintainState: true,
                            maintainAnimation: true,
                            maintainSize: false,
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 16),
                                _HomeDepartmentsWidget(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _HomeTitleWidget extends StatelessWidget {
  const _HomeTitleWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: AppColors.kWhite,
          radius: 25,
          backgroundImage: NetworkImage(
              'https://s3-alpha-sig.figma.com/img/9fe1/b697/0d0c2ba1150092f7851f1f53f805adee?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=TL820eFXYHjF~bi5QrjFnFlHtcl8iUlLk-kX9eRXsLuQ-fPV~wxFvmOaY8HWTc6DnHWREY1IxP0bQ8pbZxB7WRO8Rm2rpD7VSEgMSw-1ZwGJk9ZEU~NgqhaowWtBWDUbSNoeZiSVR5Bziy1hQLrZpmnkgn2yROKFleBEuoItI8b46jZcBjitXnboapj21-F6uzeQreuLELSbXgIWiN36J8-U9CuadGGDinDRWFb2RLw9SxESTM0HL41nYNtoqgUWfPKauhRujYdP4WjBNFXpYiKHNuG-xZJFkNdvOn7iqsXoL5lDl48PQefgCVlquDZyd3AxC5Ccxl5OP-Hxs7pdkA__'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(
                text: '${AppStrings.goodMorning.tr}👋',
                style: AppTextStyles.bodyMReq,
              ),
              MainText(
                text: 'أحمد',
                style: AppTextStyles.w700Font18Primary500,
              ),
            ],
          ),
        ),
        CircleAvatar(
          backgroundColor: AppColors.kWhite,
          radius: 25,
          child: SvgPicture.asset(AppSvg.notification),
        )
      ],
    );
  }
}

class _HomeAuctionOrBundleTaps extends StatelessWidget {
  const _HomeAuctionOrBundleTaps();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is HomeTitleTypeChanged,
      builder: (context, state) {
        final homeCubit = context.read<HomeCubit>();
        final currentType = homeCubit.getHomeTitleType;

        final Map<HomeTitleType, Widget> segmentOptions = {
          HomeTitleType.auction: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text(
              AppStrings.bidding.tr,
              style: AppTextStyles.bodySMed,
              textAlign: TextAlign.center,
            ),
          ),
          HomeTitleType.bundle: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text(
              AppStrings.packages.tr,
              style: AppTextStyles.bodySMed,
              textAlign: TextAlign.center,
            ),
          ),
        };

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: CupertinoSlidingSegmentedControl<HomeTitleType>(
              children: segmentOptions,
              groupValue: currentType,
              onValueChanged: (HomeTitleType? value) {
                if (value != null) {
                  homeCubit.setHomeTitleType = value;
                }
              },
              thumbColor: AppColors.kWhite,
              backgroundColor: AppColors.kGeryText10,
            ),
          ),
        );
      },
    );
  }
}

class _HomeDepartmentsWidget extends StatelessWidget {
  const _HomeDepartmentsWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MainText(
              text: AppStrings.departments.tr,
              style: AppTextStyles.bodyMMed
                  .copyWith(color: AppColors.kOpacityBlack),
            ),
            MainText(
              text: AppStrings.viewAll.tr,
              style: AppTextStyles.bodyXsMed
                  .copyWith(color: AppColors.kPrimary500),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 86,
          child: BlocBuilder<CategoryCubit, CategoryState>(
            buildWhen: (previous, current) =>
                current is GetCategoriesLoading ||
                current is GetCategoriesError ||
                current is GetCategoriesSucess ||
                current is ChoosenCategoryUpdated,
            builder: (context, state) {
              final cubit = context.read<CategoryCubit>();
              if (state is GetCategoriesLoading) {
                return const Center(
                  child: SizedBox(
                    height: 100,
                    child: AdaptiveCircularProgress(),
                  ),
                );
              }

              if (state is GetCategoriesError) {
                return ErrorMessageWidget(
                  error: state.error,
                  message: state.error.message,
                  onTap: () => cubit.categoriesStatesHandled(),
                );
              }

              if (state is GetCategoriesSucess || cubit.allCategories != null) {
                if (cubit.allCategories!.isEmpty) {
                  return const EmptyWidget();
                } else {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoryWidget(
                        category: cubit.allCategories![index],
                        isSelected: cubit
                            .isCategoryChoosen(cubit.allCategories![index]),
                        onTap: () => cubit.checkAndToggleCategory(
                            cubit.allCategories![index]),
                        type: CategoryWidgetType.type2,
                        animationDuration: (index * 10).ms,
                        width: 75,
                        height: 86,
                        borderRadiusValue: AppRadiuos.rM,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                    itemCount: cubit.allCategories!.length,
                  );
                }
              }
              return const SizedBox.shrink();
            },
          ),
        )
      ],
    );
  }
}
