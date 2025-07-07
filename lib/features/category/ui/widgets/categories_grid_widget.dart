import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'category_widget.dart';
import '../../../../../core/utils/widgets/empty/empty_state.dart';
import '../../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../../core/utils/widgets/loading/adaptive_circle_progress.dart';
import '../../logic/category_cubit.dart';

class ChooseCategoriesGridWidget extends StatelessWidget {
  const ChooseCategoriesGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      buildWhen: (previous, current) =>
          current is GetCategoriesLoading ||
          current is GetCategoriesSuccess ||
          current is GetCategoriesError ||
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

        if (state is GetCategoriesSuccess || cubit.allCategories != null) {
          if (cubit.allCategories!.isEmpty) {
            return const EmptyState();
          } else {
            cubit.allCategories!.removeWhere((e) => e.id == -1);
            return StaggeredGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: List.generate(cubit.allCategories!.length, (index) {
                return CategoryWidget(
                  category: cubit.allCategories![index],
                  isSelected:
                      cubit.isCategoryChosen(cubit.allCategories![index]),
                  onTap: () =>
                      cubit.checkAndToggleCategory(cubit.allCategories![index]),
                  type: CategoryWidgetType.type1,
                  animationDuration: (index * 10).ms,
                );
              }),
            );
          }
        }

        return const SizedBox.shrink();
      },
    );
  }
}
