import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../../../core/services/cache/shared_helper.dart';
import '../../../core/utils/enums/enums.dart';
import '../../category/data/entity/category_entity.dart';
import '../../user/data/entity/user_entity.dart';
import '../../user/logic/user_cubit.dart';
import '../data/params/edit_favourite_categories_params.dart';
import '../data/repository/edit_favourite_categories_repo.dart';
import 'edit_favourite_categories_state.dart';

class EditFavouriteCategoriesCubit extends Cubit<EditFavouriteCategoriesState> {
  EditFavouriteCategoriesCubit() : super(EditFavouriteCategoriesInitial()) {
    onStart();
  }
//---------------------------------VARIABLES----------------------------------//

  final categories = BehaviorSubject<List<CategoryEntity>>();
  Function(List<CategoryEntity>) get updateCategories => categories.sink.add;
  Stream<List<CategoryEntity>> get categoriesStream =>
      categories.stream.asBroadcastStream();

//---------------------------------FUNCTIONS----------------------------------//

  bool isRegisterValidate() {
    if (categories.valueOrNull != null && categories.valueOrNull!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> close() {
    categories.close();
    return super.close();
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> editProfileStatesHandled() async {
    emit(const EditFavouriteCategoriesLoading());
    final UserEntity? user = CustomNavigator.navigatorState.currentContext!
        .read<UserCubit>()
        .userEntity;
    final response = await EditFavouriteCategoriesRepo.editProfile(
      EditFavouriteCategoriesParams(
          email: user?.email ?? '',
          firstName: user?.firstName ?? '',
          lastName: user?.lastName ?? '',
          city: user?.city?.id ?? 0,
          age: user?.age?.id ?? 0,
          gender: user?.gender ?? GenderTypes.male,
          phone: user?.phone ?? '',
          categories: categories.valueOrNull!),
    );
    response.fold((failure) {
      return emit(EditFavouriteCategories(failure));
    }, (success) async {
      await SharedHelper.sharedHelper?.saveUser(success);

      return emit(EditFavouriteCategoriesSuccess(success));
    });
  }

  Future<void> onStart() async {
    final UserEntity? user = CustomNavigator.navigatorState.currentContext!
        .read<UserCubit>()
        .userEntity;

    updateCategories(user?.favoriteCategories ?? []);

    return emit(EditFavouriteCategoriesInitial());
  }
}
