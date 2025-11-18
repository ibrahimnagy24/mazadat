import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../data/entity/category_entity.dart';
import '../data/repo/category_repo.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
//---------------------------------VARIABLES----------------------------------//
  List<CategoryEntity> chosenCategories = [];
  List<CategoryEntity>? _allCategories;
  // CategoryEntity(
  //   id: -1,
  //   name: AppStrings.bundles.tr,
  //   description: '',
  //   iconUrl: '',
  //   categoryType: CategoryTypes.bundle,
  // ),

//---------------------------------FUNCTIONS----------------------------------//
  List<CategoryEntity>? get allCategories => _allCategories;
  void checkAndToggleCategory(CategoryEntity category) {
    if (chosenCategories.contains(category)) {
      chosenCategories.remove(category);
    } else {
      chosenCategories.add(category);
    }
    emit(ChosenCategoryUpdated());
  }

  void initChosenCategory(List<CategoryEntity>? categories) {
    chosenCategories = categories ?? [];
  }

  CategoryEntity? _selectedCategory;
  CategoryEntity? get selectedCategory => _selectedCategory;
  void updateSelectedCategory(CategoryEntity? category) {
    if (category?.id == _selectedCategory?.id) {
      _selectedCategory = null;
    } else {
      _selectedCategory = category;
    }
    emit(ChosenCategoryUpdated());
  }

  bool isCategoryChosen(CategoryEntity interest) {
    return chosenCategories.contains(interest);
  }

  bool isSelected(CategoryEntity interest) {
    return selectedCategory?.id == interest.id;
  }

  bool hasChosenCategories() {
    return chosenCategories.isNotEmpty;
  }

  void clearSelectedCategory() {
    _selectedCategory = null;
    emit(ChosenCategoryUpdated());
  }

//----------------------------------REQUEST-----------------------------------//

  Future<void> categoriesStatesHandled() async {
    emit(const GetCategoriesLoading());
    final response = await CategoryRepo.categories();
    response.fold((failure) {
      return emit(GetCategoriesError(failure));
    }, (success) async {
      _allCategories = success;

      return emit(GetCategoriesSuccess(success));
    });
  }
}
