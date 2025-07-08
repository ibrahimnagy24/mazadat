import '../../../../core/shared/entity/error_entity.dart';
import '../../user/data/entity/user_entity.dart';


sealed class EditFavouriteCategoriesState {
  const EditFavouriteCategoriesState();
}

final class EditFavouriteCategoriesInitial extends EditFavouriteCategoriesState {}

final class EditFavouriteCategoriesLoading extends EditFavouriteCategoriesState {
  const EditFavouriteCategoriesLoading();
}

final class EditFavouriteCategoriesSuccess extends EditFavouriteCategoriesState {
  const EditFavouriteCategoriesSuccess(this.userEntity);
  final UserEntity userEntity;
}

final class EditFavouriteCategories extends EditFavouriteCategoriesState {
  const EditFavouriteCategories(this.error);
  final ErrorEntity error;
}

