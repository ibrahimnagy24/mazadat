import 'package:equatable/equatable.dart';

class RegionParams extends Equatable {
  final int page;
  final int limit;

  const RegionParams({
    required this.page,
    required this.limit,
  });

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'page': page,
      'limit': limit,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [page, limit];
}
