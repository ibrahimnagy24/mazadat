import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../data/entity/age_entity.dart';
import '../data/repo/age_repo.dart';
part 'age_state.dart';

class AgeCubit extends Cubit<AgeState> {
  AgeCubit() : super(AgeStart());
//---------------------------------VARIABLES----------------------------------//
  List<AgeEntity>? _allCities;

//---------------------------------FUNCTIONS----------------------------------//
  List<AgeEntity>? get allCities => _allCities;

  Future<void> citiesStatesHandled() async {
    emit(AgeLoading());
    final response = await CitiesRepo.getAges();
    response.fold((failure) {
      return emit(AgeError(failure));
    }, (success) async {
      _allCities = success;
      if (_allCities != null && _allCities!.isNotEmpty) {
        return emit(AgeDone(success));
      } else {
        return emit(AgeEmpty());
      }
    });
  }
}
