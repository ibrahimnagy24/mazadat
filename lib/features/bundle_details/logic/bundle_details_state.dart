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
