import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/category_entity.dart';
import 'category_widget.dart';
import '../../../../core/theme/radiuos/app_radius.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/loading/adaptive_circle_progress.dart';
import '../../logic/category_cubit.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key, this.onTap});
  final Function(CategoryEntity?)? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        buildWhen: (previous, current) =>
            current is GetCategoriesLoading ||
            current is GetCategoriesError ||
            current is GetCategoriesSuccess ||
            current is ChosenCategoryUpdated,
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

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 18.w),
                ...List.generate(
                    cubit.allCategories!.length,
                    (index) => CategoryWidget(
                          category: cubit.allCategories![index],
                          isSelected: cubit.selectedCategory ==
                              cubit.allCategories![index],
                          onTap: () {
                            if(cubit.selectedCategory ==
                                cubit.allCategories![index]){
                              cubit.updateSelectedCategory(null);
                              onTap?.call(null);
                            }else {
                              cubit.updateSelectedCategory(
                                  cubit.allCategories![index]);
                              onTap?.call(cubit.allCategories![index]);
                            }

                          },
                          type: CategoryWidgetType.type2,
                          animationDuration: (index * 10).ms,
                          width: 75.w,
                          height: 90.h,
                          borderRadiusValue: AppRadius.rM,
                        ))
              ],
            ),
          );
        },
      ),
    );
  }
}
