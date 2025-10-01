import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/shared/widgets/category_widget.dart';
import '../../../../../core/theme/radius/app_radius.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/shimmer/custom_shimmer.dart';
import '../../../../category/data/entity/category_entity.dart';
import '../../../../category/logic/category_cubit.dart';

class CategoriesFilterSection extends StatelessWidget {
  const CategoriesFilterSection({super.key, this.onTap, this.initialValues});
  final Function(List<CategoryEntity>)? onTap;
  final List<CategoryEntity>? initialValues;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text(
            AppStrings.categories.tr,
            style: AppTextStyles.textLgBold
                .copyWith(color: const Color.fromRGBO(46, 46, 46, 1)),
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
                  spacing: 8,
                  runSpacing: 8,
                  runAlignment: WrapAlignment.start,
                  children: List.generate(
                    5,
                    (index) => const CustomShimmerContainer(
                      width: 80,
                      height: 35,
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
                  spacing: 8,
                  runSpacing: 8,
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
                      borderRadiusValue: 12,
                      textStyle: AppTextStyles.textMdRegular.copyWith(
                        color:
                            cubit.isCategoryChosen(cubit.allCategories![index])
                                ? const Color.fromRGBO(81, 94, 50, 1)
                                : const Color.fromRGBO(162, 162, 162, 1),
                      ),
                      fillColor:
                          cubit.isCategoryChosen(cubit.allCategories![index])
                              ? const Color.fromRGBO(81, 94, 50, 0.1)
                              : Colors.transparent,
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
