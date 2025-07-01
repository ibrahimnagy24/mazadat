import 'package:equatable/equatable.dart';

import '../enums/auction_enums.dart';

class AuctionParams extends Equatable {
  final int? page;
  final int? size;
  final AuctionType? type;
  final int? categoryId;
  const AuctionParams({
    this.page,
    this.size,
    this.categoryId,
    this.type,
  });
  @override
  List<Object?> get props => [page, size, type, categoryId];
  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'page': page,
      'size': size,
      'categoryIds': categoryId,
      'type': type?.name,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
