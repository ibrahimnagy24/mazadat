import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../category/logic/category_cubit.dart';
import '../../../category/ui/widgets/horizontal_categories_list_widget.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';

class HomeCategoriesListWidget extends StatelessWidget {
  const HomeCategoriesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..categoriesStatesHandled(),
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) => current is HomeDataTypeChanged,
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (cubit.getIsBundleSelected) {
                    cubit.isBundleSelected = false;
                  } else {
                    cubit.isBundleSelected = true;
                    context.read<CategoryCubit>().clearSelectedCategory();
                  }
                },
                child: Container(
                  height: 95,
                  width: 75,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    border: Border.all(
                      color: cubit.getIsBundleSelected
                          ? AppColors.kPrimary500
                          : AppColors.borderNeutralSecondary,
                      width: cubit.getIsBundleSelected ? 1.5 : .6,
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.rMD),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 4,
                        ),
                        child: SvgPicture.asset(
                          AppSvg.package,
                          color: cubit.getIsBundleSelected
                              ? AppColors.iconColor
                              : AppColors.textSecondaryParagraph,
                          fit: BoxFit.contain,
                          height: 28,
                          width: 28,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              AppStrings.bundles.tr,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: cubit.getIsBundleSelected
                                  ? AppTextStyles.textMdBold
                                      .copyWith(color: AppColors.kPrimary500)
                                  : AppTextStyles.textMdRegular.copyWith(
                                      color: AppColors.textSecondaryParagraph),
                            ),
                            if (cubit.getIsBundleSelected)
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                height: 3,
                                width: 15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppColors.kPrimary300,
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<CategoryCubit, CategoryState>(
                  buildWhen: (previous, current) =>
                      current is GetCategoriesLoading ||
                      current is GetCategoriesError ||
                      current is GetCategoriesSuccess ||
                      current is ChosenCategoryUpdated,
                  builder: (context, state) {
                    final cubit = context.read<HomeCubit>();
                    return HorizontalCategoriesListWidget(
                      cubit: context.read<CategoryCubit>(),
                      state: state,
                      onSelectedCallback: (category) {
                        cubit.selectedCategory = category;
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
