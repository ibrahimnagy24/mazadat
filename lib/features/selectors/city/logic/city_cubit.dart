import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../data/entity/city_entity.dart';
import '../data/params/city_params.dart';
import '../data/repo/cities_repo.dart';
part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit() : super(CityStart());
//---------------------------------VARIABLES----------------------------------//
  List<CityEntity>? cities;

//---------------------------------FUNCTIONS----------------------------------//

//----------------------------------REQUEST----------------------------------//

  Future<void> citiesStatesHandled({CityParams? params}) async {
    CustomNavigator.context.loaderOverlay.show();
    emit(const GetCitiesLoading());
    final response = await CitiesRepo.getCities(
      params ??
          const CityParams(
            regionId: 12,
            page: 0,
            limit: 100000,
          ),
    );
    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(GetCitiesError(failure));
    }, (success) {
      cities = success;
      CustomNavigator.context.loaderOverlay.hide();
      if (success.isEmpty) {
        return emit(const GetCitiesEmpty());
      }
      return emit(GetCitiesDone(success));
    });
  }
}
