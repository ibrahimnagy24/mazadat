import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../data/entity/district_entity.dart';
import '../data/params/district_params.dart';
import '../data/repo/districts_repo.dart';
part 'district_state.dart';

class DistrictsCubit extends Cubit<DistrictState> {
  DistrictsCubit() : super(DistrictStart());
//---------------------------------VARIABLES----------------------------------//
  List<DistrictEntity>? districts;

//---------------------------------FUNCTIONS----------------------------------//

//----------------------------------REQUEST----------------------------------//

  Future<void> districtsStatesHandled({DistrictParams? params}) async {
    CustomNavigator.context.loaderOverlay.show();
    emit(const GetDistrictsLoading());
    final response = await DistrictsRepo.getDistricts(
      params ??
          const DistrictParams(
            cityId: 1,
            page: 0,
            limit: 100000,
          ),
    );
    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(GetDistrictsError(failure));
    }, (success) {
      districts = success;
      CustomNavigator.context.loaderOverlay.hide();
      if (success.isEmpty) {
        return emit(const GetDistrictsEmpty());
      }
      return emit(GetDistrictsDone(success));
    });
  }
}
