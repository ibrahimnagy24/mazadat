import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/entity/bundle_entity.dart';
import '../data/params/bundle_params.dart';
import '../data/repo/bundles_repo.dart';
import 'bundles_state.dart';

class BundlesCubit extends Cubit<BundlesState> {
  BundlesCubit() : super(const BundlesInitial());
//---------------------------------VARIABLES----------------------------------//

  List<BundleEntity>? allBundles;
  bool isList = false;

//---------------------------------FUNCTIONS----------------------------------//

  // updateListingCard() {
  //   isList = !isList;
  //   emit(ListingState());
  // }

//----------------------------------REQUEST-----------------------------------//
  Future<void> bundlesStatesHandled({BundleParams? params}) async {
    emit(const BundlesLoading());
    final response = await BundlesRepo.bundles(params);
    response.fold((failure) {
      return emit(BundlesError(failure));
    }, (success) {
      allBundles = success;
      emit(BundlesSuccess(success));
    });
  }
}
