import 'package:equatable/equatable.dart';


class FavouritesParams extends Equatable {
  final int? page;
  final int? size;
  const FavouritesParams({
    this.page,
    this.size,
  });
  @override
  List<Object?> get props => [page, size];
  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'page': page,
      'size': size,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
