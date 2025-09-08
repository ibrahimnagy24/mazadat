import 'package:equatable/equatable.dart';

class DistrictParams extends Equatable {
  final int page;
  final int limit;
  final int cityId;

  const DistrictParams({
    required this.page,
    required this.limit,
    required this.cityId,
  });

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'page': page,
      'limit': limit,
      'cityId': cityId,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [page, limit, cityId];
}
