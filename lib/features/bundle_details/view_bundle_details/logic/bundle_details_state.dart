part of 'bundle_details_cubit.dart';

sealed class BundleDetailsState extends Equatable {
  const BundleDetailsState();

  @override
  List<Object> get props => [];
}

class BundleDetailsInitial extends BundleDetailsState {}

class BundleDetailsLoading extends BundleDetailsState {
  const BundleDetailsLoading();
}

class BundleDetailsEmpty extends BundleDetailsState {
  const BundleDetailsEmpty();
}

class BundleDetailsSuccess extends BundleDetailsState {
  final BundleDetailsModel bundleDetails;
  const BundleDetailsSuccess(this.bundleDetails);
}

class BundleDetailsError extends BundleDetailsState {
  final ErrorEntity errorEntity;
  const BundleDetailsError(this.errorEntity);
}

class BundleDetailsBackgroundRefresh extends BundleDetailsState {
  final BundleDetailsModel bundleDetails;
  const BundleDetailsBackgroundRefresh(this.bundleDetails);
}

class ValidateJoiningAuctionInitial extends BundleDetailsState {}

class ValidateJoiningAuctionLoading extends BundleDetailsState {}

class ValidateJoiningAuctionSuccess extends BundleDetailsState {
  final AuctionPolicyModel data;
  const ValidateJoiningAuctionSuccess({required this.data});
}

class ValidateJoiningAuctionError extends BundleDetailsState {
  final ErrorEntity error;
  const ValidateJoiningAuctionError(this.error);
}
