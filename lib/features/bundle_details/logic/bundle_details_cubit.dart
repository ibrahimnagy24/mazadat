import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared/entity/error_entity.dart';
import '../../../core/shared/models/auction_policy_model.dart';
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

  Future<void> validate(int id) async {
    emit(ValidateJoiningAuctionLoading());

    final response = await BundleDetailsRepo.validateJoiningAuction(id);
    response.fold((failure) {
      return emit(ValidateJoiningAuctionError(failure));
    }, (success) {
      if (success.statusCode == 200 && success.data != null) {
        AuctionPolicyModel? res = AuctionPolicyModel.fromJson(success.data);
        return emit(ValidateJoiningAuctionSuccess(data: res));
      } else {
        return emit(ValidateJoiningAuctionError(ErrorEntity(
            message: success.data['MESSAGE'],
            statusCode: success.statusCode ?? 400,
            errors: const [])));
      }
    });
  }
}
