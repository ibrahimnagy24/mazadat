import 'package:equatable/equatable.dart';

class HomeAuctionParams extends Equatable {
  final int? categoryId;
  final int? page;
  final int size;

  const HomeAuctionParams({
    this.categoryId,
    this.page,
    required this.size,
  });

  @override
  List<Object?> get props => [categoryId, page, size];

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'categoryIds': categoryId,
      'page': page,
      'size': size,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
