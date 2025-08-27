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
              context
                  .read<CategoryCubit>()
                  .allCategories!
                  .removeWhere((e) => e.id == -1);
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
                                context
                                    .read<CategoryCubit>()
                                    .allCategories!
                                    .length, (index) {
                              return CategoryWidget(
                                category: context
                                    .read<CategoryCubit>()
                                    .allCategories![index],
                                isSelected: snapshot.data?.any((e) =>
                                        e.id ==
                                        context
                                            .read<CategoryCubit>()
                                            .allCategories![index]
                                            .id) ??
                                    false,
                                onTap: () {
                                  if (snapshot.data?.contains(context
                                          .read<CategoryCubit>()
                                          .allCategories![index]) ==
                                      true) {
                                    snapshot.data?.remove(context
                                        .read<CategoryCubit>()
                                        .allCategories![index]);
                                  } else {
                                    snapshot.data?.add(context
                                        .read<CategoryCubit>()
                                        .allCategories![index]);
                                  }
                                  context
                                      .read<EditFavouriteCategoriesCubit>()
                                      .updateCategories(snapshot.data!);
                                },
                                type: CategoryWidgetType.type1,
                                animationDuration: (index * 10).ms,
                              );
                            }),
                          )
                        : const SizedBox.shrink();
                  });
            }
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
