part of 'region_cubit.dart';

sealed class RegionState {
  const RegionState();
}

final class RegionStart extends RegionState {}

final class GetRegionsLoading extends RegionState {
  const GetRegionsLoading();
}

final class GetRegionsEmpty extends RegionState {
  const GetRegionsEmpty();
}

final class GetRegionsDone extends RegionState {
  GetRegionsDone(this.regions);
  final List<RegionEntity> regions;
}

final class GetRegionsError extends RegionState {
  const GetRegionsError(this.error);
  final ErrorEntity error;
}
