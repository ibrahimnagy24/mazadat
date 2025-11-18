import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/radius/app_radius.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/empty/responsive_empty_widget.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../data/entity/category_entity.dart';
import '../../logic/category_cubit.dart';
import '../../../../core/shared/widgets/category_widget.dart';

class HorizontalCategoriesListWidget extends StatelessWidget {
  const HorizontalCategoriesListWidget({
    super.key,
    required this.cubit,
    required this.state,
    required this.onSelectedCallback,
  });
  final CategoryCubit cubit;
  final CategoryState state;
  final Function(CategoryEntity? category) onSelectedCallback;
  @override
  Widget build(BuildContext context) {
    if (state is GetCategoriesLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is GetCategoriesError) {
      return ErrorMessageWidget(
        error: (state as GetCategoriesError).error,
        message: (state as GetCategoriesError).error.message,
        onTap: () => cubit.categoriesStatesHandled(),
      );
    }

    if (cubit.allCategories != null && cubit.allCategories!.isNotEmpty) {
      return SizedBox(
        height: 95,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return CategoryWidget(
              category: cubit.allCategories![index],
              isSelected: cubit.isSelected(cubit.allCategories![index]),
              onTap: () {
                cubit.updateSelectedCategory(cubit.allCategories![index]);
                onSelectedCallback(cubit.selectedCategory);
              },
              type: CategoryWidgetType.type2,
              animationDuration: 300.ms,
              width: 75,
              borderRadiusValue: AppRadius.rMD,
            );
          },
          itemCount: cubit.allCategories!.length,
        ),
      );
    }

    if (cubit.allCategories != null && cubit.allCategories!.isEmpty) {
      return ResponsiveEmptyWidget(
        title: AppStrings.noCategoriesFound.tr,
        subtitle: AppStrings.thereAreNoCategoriesAvailableAtTheMoment.tr,
        showImage: false,
        onTap: () {
          cubit.categoriesStatesHandled();
        },
      );
    }

    return const SizedBox.shrink();
  }
}
