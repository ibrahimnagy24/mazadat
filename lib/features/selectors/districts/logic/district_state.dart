part of 'district_cubit.dart';

sealed class DistrictState {
  const DistrictState();
}

final class DistrictStart extends DistrictState {}

final class DistrictLoading extends DistrictState {}
final class DistrictEmpty extends DistrictState {}

final class DistrictSuccess extends DistrictState {
  const DistrictSuccess({required this.districts,this.isLoading = false});
  final bool isLoading;

  final List<DistrictEntity> districts;
}

final class DistrictError extends DistrictState {
  const DistrictError(this.error);
  final ErrorEntity error;
}
