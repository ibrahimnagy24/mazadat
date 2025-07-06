import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../data/entity/category_entity.dart';
import 'category_widget.dart';
import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../logic/category_cubit.dart';

class CategoriesFilterSection extends StatelessWidget {
  const CategoriesFilterSection({super.key, this.onTap, this.initialValues});
  final Function(List<CategoryEntity>)? onTap;
  final List<CategoryEntity>? initialValues;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Text(
            AppStrings.categories.tr,
            style: AppTextStyles.textLgBold,
          ),
          BlocBuilder<CategoryCubit, CategoryState>(
            buildWhen: (previous, current) =>
                current is GetCategoriesLoading ||
                current is GetCategoriesError ||
                current is GetCategoriesSuccess ||
                current is ChosenCategoryUpdated,
            builder: (context, state) {
              final cubit = context.read<CategoryCubit>();
              if (state is GetCategoriesLoading) {
                return Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8.h,
                  runSpacing: 8.w,
                  runAlignment: WrapAlignment.start,
                  children: List.generate(
                    5,
                    (index) => CustomShimmerContainer(
                      width: 80.w,
                      height: 35.h,
                    ),
                  ),
                );
              }

              if (state is GetCategoriesSuccess ||
                  state is ChosenCategoryUpdated) {
                ///to Remove Bundle Card
                cubit.allCategories!.removeWhere((e) => e.id == -1);
                context.read<CategoryCubit>().initChosenCategory(initialValues);

                return Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8.h,
                  runSpacing: 8.w,
                  runAlignment: WrapAlignment.start,
                  children: List.generate(
                    cubit.allCategories!.length,
                    (index) => CategoryWidget(
                      category: cubit.allCategories![index],
                      isSelected:
                          cubit.isCategoryChosen(cubit.allCategories![index]),
                      onTap: () {
                        cubit.checkAndToggleCategory(
                            cubit.allCategories![index]);
                        onTap?.call(cubit.chosenCategories);
                      },
                      type: CategoryWidgetType.type3,
                      animationDuration: (index * 10).ms,
                      borderRadiusValue: AppRadius.rM,
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
