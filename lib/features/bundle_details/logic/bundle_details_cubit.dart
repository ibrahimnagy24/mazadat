import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared/entity/error_entity.dart';
import '../data/model/bundle_details_model.dart';
import '../data/params/bundle_details_route_params.dart';
import '../data/repo/bundle_details_repo.dart';
part 'bundle_details_state.dart';

class BundleDetailsCubit extends Cubit<BundleDetailsState> {
  BundleDetailsCubit() : super(BundleDetailsInitial());
//---------------------------------VARIABLES----------------------------------//
  BundleDetailsModel? bundleDetailsModel;
//----------------------------------REQUEST-----------------------------------//

  Future<void> getBundleDetails(BundleDetailsRouteParams params) async {
    emit(const BundleDetailsLoading());
    final response = await BundleDetailsRepo.getBundleDetails(params);
    response.fold((failure) {
      return emit(BundleDetailsError(failure));
    }, (success) {
      bundleDetailsModel = success;
      return emit(BundleDetailsSuccess(success));
    });
  }
}
