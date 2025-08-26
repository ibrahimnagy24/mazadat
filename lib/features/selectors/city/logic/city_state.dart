part of 'city_cubit.dart';

sealed class CityState {
  const CityState();
}

final class CityStart extends CityState {}

final class GetCitiesLoading extends CityState {
  const GetCitiesLoading();
}

final class GetCitiesEmpty extends CityState {
  const GetCitiesEmpty();
}

final class GetCitiesDone extends CityState {
  GetCitiesDone(this.cities);
  final List<CityEntity> cities;
}

final class GetCitiesError extends CityState {
  const GetCitiesError(this.error);
  final ErrorEntity error;
}
