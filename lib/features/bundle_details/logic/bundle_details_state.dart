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
  const BundleDetailsSuccess({required this.bundleDetails});
}

class BundleDetailsError extends BundleDetailsState {
  final ErrorEntity error;
  const BundleDetailsError(this.error);
}
