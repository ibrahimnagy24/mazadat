import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../data/entity/city_entity.dart';
import '../data/repo/cities_repo.dart';
part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit() : super(CityStart());
//---------------------------------VARIABLES----------------------------------//
  List<CityEntity>? _allCities;

//---------------------------------FUNCTIONS----------------------------------//
  List<CityEntity>? get allCities => _allCities;

  Future<void> citiesStatesHandled() async {
    emit(CityLoading());
    final response = await CitiesRepo.getCities();
    response.fold((failure) {
      return emit(CityError(failure));
    }, (success) async {
      _allCities = success;
      if (_allCities != null && _allCities!.isNotEmpty) {
        return emit(CityDone(success));
      } else {
        return emit(CityEmpty());
      }
    });
  }
}
