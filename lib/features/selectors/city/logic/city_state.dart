part of 'city_cubit.dart';

sealed class CityState {
  const CityState();
}

final class CityStart extends CityState {}

final class CityLoading extends CityState {}
final class CityEmpty extends CityState {}

final class CityDone extends CityState {
  const CityDone(this.cities);
  final List<CityEntity> cities;
}

final class CityError extends CityState {
  const CityError(this.error);
  final ErrorEntity error;
}
