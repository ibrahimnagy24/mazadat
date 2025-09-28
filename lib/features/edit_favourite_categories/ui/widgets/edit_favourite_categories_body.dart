import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/widgets/animated/grid_list_animator.dart';
import '../../../../core/utils/widgets/empty/empty_state.dart';
import '../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../core/utils/widgets/loading/adaptive_circle_progress.dart';
import '../../../category/logic/category_cubit.dart';
import '../../../../core/shared/widgets/category_widget.dart';
import '../../logic/edit_favourite_categories_cubit.dart';
import '../../../category/data/entity/category_entity.dart';

class EditFavouriteCategoriesBody extends StatelessWidget {
  const EditFavouriteCategoriesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
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
              onTap: () =>
                  context.read<CategoryCubit>().categoriesStatesHandled(),
            );
          }

          if (state is GetCategoriesSuccess ||
              context.read<CategoryCubit>().allCategories != null) {
            if (context.read<CategoryCubit>().allCategories!.isEmpty) {
              return const EmptyState();
            } else {
              // Use a locally filtered list to avoid mutating cubit's state in build
              final categories = context
                  .read<CategoryCubit>()
                  .allCategories!
                  .where((e) => e.id != -1)
                  .toList(growable: false);
              return StreamBuilder(
                stream: context
                    .read<EditFavouriteCategoriesCubit>()
                    .categoriesStream,
                builder: (context, snapshot) {
                  return snapshot.data != null
                      ? GridListAnimator(
                          crossAxisCount: 3,
                          aspectRatio: 1,
                          data: List.generate(
                            categories.length,
                            (index) {
                              return CategoryWidget(
                                category: categories[index],
                                isSelected: snapshot.data?.any(
                                        (e) => e.id == categories[index].id) ??
                                    false,
                                onTap: () {
                                  // Work on a mutable copy; snapshot.data may be unmodifiable
                                  final List<CategoryEntity> current =
                                      List<CategoryEntity>.of(snapshot.data ??
                                          const <CategoryEntity>[]);
                                  final tapped = categories[index];
                                  final exists =
                                      current.any((e) => e.id == tapped.id);
                                  if (exists) {
                                    current
                                        .removeWhere((e) => e.id == tapped.id);
                                  } else {
                                    current.add(tapped);
                                  }
                                  context
                                      .read<EditFavouriteCategoriesCubit>()
                                      .updateCategories(current);
                                },
                                type: CategoryWidgetType.type1,
                                animationDuration: (index * 10).ms,
                              );
                            },
                          ),
                        )
                      : const SizedBox.shrink();
                },
              );
            }
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
