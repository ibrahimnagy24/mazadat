import 'package:equatable/equatable.dart';

class HomeAuctionParams extends Equatable {
  final int? page;
  final int? size;
  final String endPoint;
  const HomeAuctionParams({
    this.page,
    this.size,
    required this.endPoint,
  });
  @override
  List<Object?> get props => [page, size, endPoint];
  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'page': page,
      'size': size,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
