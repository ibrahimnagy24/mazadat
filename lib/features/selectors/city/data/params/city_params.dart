import 'package:equatable/equatable.dart';

class CityParams extends Equatable {
  final int page;
  final int limit;
  final int regionId;

  const CityParams({
    required this.page,
    required this.limit,
    required this.regionId,
  });

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'page': page,
      'limit': limit,
      'regionId': regionId,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [page, limit];
}
