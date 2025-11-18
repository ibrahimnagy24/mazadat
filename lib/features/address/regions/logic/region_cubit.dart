import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../data/entity/region_entity.dart';
import '../data/params/region_params.dart';
import '../data/repo/regions_repo.dart';
part 'region_state.dart';

class RegionsCubit extends Cubit<RegionState> {
  RegionsCubit() : super(RegionStart());
//---------------------------------VARIABLES----------------------------------//
  List<RegionEntity>? regions;

//---------------------------------FUNCTIONS----------------------------------//

//----------------------------------REQUEST----------------------------------//

  Future<void> regionsStatesHandled({RegionParams? params}) async {
    CustomNavigator.context.loaderOverlay.show();
    emit(const GetRegionsLoading());
    final response = await RegionsRepo.getRegions(
      params ??
          const RegionParams(
            page: 0,
            limit: 100000,
          ),
    );
    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(GetRegionsError(failure));
    }, (success) {
      regions = success;
      CustomNavigator.context.loaderOverlay.hide();
      if (success.isEmpty) {
        return emit(const GetRegionsEmpty());
      }
      return emit(GetRegionsDone(success));
    });
  }
}
