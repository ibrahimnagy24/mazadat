part of 'district_cubit.dart';

sealed class DistrictState {
  const DistrictState();
}

final class DistrictStart extends DistrictState {}

final class GetDistrictsLoading extends DistrictState {
  const GetDistrictsLoading();
}

final class GetDistrictsEmpty extends DistrictState {
  const GetDistrictsEmpty();
}

final class GetDistrictsDone extends DistrictState {
  GetDistrictsDone(this.districts);
  final List<DistrictEntity> districts;
}

final class GetDistrictsError extends DistrictState {
  const GetDistrictsError(this.error);
  final ErrorEntity error;
}
