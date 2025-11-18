import 'package:equatable/equatable.dart';

class AuctionParams extends Equatable {
  final int page;
  final int size;
  final String? query;

  const AuctionParams({
    this.page = 0,
    this.size = 10000,
    this.query,
  });

  @override
  List<Object?> get props => [page, size, query];

  Map<String, dynamic> returnedMap() {
    final Map<String, dynamic> map = {
      'page': page,
      'size': size,
    };
    if (query != null && query!.isNotEmpty) {
      map['query'] = query!;
    }
    return map;
  }
}
