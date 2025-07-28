part of 'region_cubit.dart';

sealed class RegionState {
  const RegionState();
}

final class RegionStart extends RegionState {}

final class RegionLoading extends RegionState {}
final class RegionEmpty extends RegionState {}

final class RegionSuccess extends RegionState {
  const RegionSuccess({required this.regions,this.isLoading = false});
  final bool isLoading;

  final List<RegionEntity> regions;
}

final class RegionError extends RegionState {
  const RegionError(this.error);
  final ErrorEntity error;
}
