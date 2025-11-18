import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/shared/models/auction_policy_model.dart';
import '../data/model/bundle_details_model.dart';
import '../data/params/bundle_details_route_params.dart';
import '../data/repo/bundle_details_repo.dart';
part 'bundle_details_state.dart';

class BundleDetailsCubit extends Cubit<BundleDetailsState> {
  BundleDetailsCubit() : super(BundleDetailsInitial());
//---------------------------------VARIABLES----------------------------------//
  BundleDetailsModel? bundleDetailsModel;
  Timer? _refreshTimer;
  BundleDetailsRouteParams? _currentParams;
//----------------------------------REQUEST-----------------------------------//

  Future<void> getBundleDetails(BundleDetailsRouteParams params,
      {bool isBackgroundRefresh = false}) async {
    _currentParams = params;

    // If we have existing data and this is a background refresh, emit background refresh state
    if (isBackgroundRefresh && bundleDetailsModel != null) {
      emit(BundleDetailsBackgroundRefresh(bundleDetailsModel!));
    } else {
      // Only show loading spinner if we don't have data
      if (bundleDetailsModel == null) {
        emit(const BundleDetailsLoading());
      }
    }

    final response = await BundleDetailsRepo.getBundleDetails(params);
    response.fold((failure) {
      // If we have existing data, keep showing it even on error
      if (bundleDetailsModel != null) {
        emit(BundleDetailsSuccess(bundleDetailsModel!));
      } else {
        emit(BundleDetailsError(failure));
      }
    }, (success) {
      bundleDetailsModel = success;
      emit(BundleDetailsSuccess(success));
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

//----------------------------------TIMER METHODS-----------------------------------//

  void startAutoRefresh() {
    stopAutoRefresh(); // Stop any existing timer
    _refreshTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (_currentParams != null) {
        getBundleDetails(_currentParams!, isBackgroundRefresh: true);
      }
    });
  }

  void stopAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  @override
  Future<void> close() {
    stopAutoRefresh();
    return super.close();
  }
}
