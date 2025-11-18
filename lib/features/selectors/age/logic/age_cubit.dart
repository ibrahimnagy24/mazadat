import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../data/entity/age_entity.dart';
import '../data/repo/age_repo.dart';
part 'age_state.dart';

class AgeCubit extends Cubit<AgeState> {
  AgeCubit() : super(AgeStart());
//---------------------------------VARIABLES----------------------------------//
  List<AgeEntity>? _agesEntity;

//---------------------------------FUNCTIONS----------------------------------//
  List<AgeEntity>? get agesEntity => _agesEntity;

//---------------------------------REQUESTS----------------------------------//

  Future<void> agesStatesHandled() async {
    CustomNavigator.context.loaderOverlay.show();
    emit(AgeLoading());
    final response = await CitiesRepo.getAges();
    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(AgeError(failure));
    }, (success) async {
      CustomNavigator.context.loaderOverlay.hide();
      _agesEntity = success;
      if (_agesEntity != null && _agesEntity!.isNotEmpty) {
        return emit(AgeDone(success));
      }
      return emit(AgeEmpty());
    });
  }
}
