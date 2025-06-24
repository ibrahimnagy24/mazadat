import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../data/entity/category_entity.dart';
import '../data/repo/category_repo.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
//---------------------------------VARIABLES----------------------------------//
  final List<CategoryEntity> _choosenCategories = [];
  List<CategoryEntity>? _allCategories;

//---------------------------------FUNCTIONS----------------------------------//
  List<CategoryEntity> get choosenCategories => _choosenCategories;
  List<CategoryEntity>? get allCategories => _allCategories;
  void checkAndToggleCategory(CategoryEntity category) {
    if (_choosenCategories.contains(category)) {
      _choosenCategories.remove(category);
    } else {
      _choosenCategories.add(category);
    }
    emit(ChoosenCategoryUpdated());
  }

  bool isCategoryChoosen(CategoryEntity interest) {
    return _choosenCategories.contains(interest);
  }

  bool hasChoosenCategories() {
    return _choosenCategories.isNotEmpty;
  }

//----------------------------------REQUEST-----------------------------------//

  Future<void> categoriesStatesHandled() async {
    emit(const GetCategoriesLoading());
    final response = await CategoryRepo.categories();
    response.fold((failure) {
      return emit(GetCategoriesError(failure));
    }, (success) async {
      _allCategories = success;
      return emit(GetCategoriesSucess(success));
    });
  }
}
