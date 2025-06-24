part of 'category_cubit.dart';

sealed class CategoryState {
  const CategoryState();
}

final class CategoryInitial extends CategoryState {}

final class ChoosenCategoryUpdated extends CategoryState {}

final class GetCategoriesLoading extends CategoryState {
  const GetCategoriesLoading();
}

final class GetCategoriesSucess extends CategoryState {
  const GetCategoriesSucess(this.categories);
  final List<CategoryEntity> categories;
}

final class GetCategoriesError extends CategoryState {
  const GetCategoriesError(this.error);
  final ErrorEntity error;
}
