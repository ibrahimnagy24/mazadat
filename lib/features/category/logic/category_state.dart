part of 'category_cubit.dart';

sealed class CategoryState {
  const CategoryState();
}

final class CategoryInitial extends CategoryState {}

final class ChosenCategoryUpdated extends CategoryState {}

final class GetCategoriesLoading extends CategoryState {
  const GetCategoriesLoading();
}

final class GetCategoriesSuccess extends CategoryState {
  const GetCategoriesSuccess(this.categories);
  final List<CategoryEntity> categories;
}

final class GetCategoriesError extends CategoryState {
  const GetCategoriesError(this.error);
  final ErrorEntity error;
}
