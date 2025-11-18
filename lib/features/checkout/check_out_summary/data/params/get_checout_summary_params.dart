import 'package:equatable/equatable.dart';

class GetCheckoutSummaryParams extends Equatable {
  final int auctionId;

  const GetCheckoutSummaryParams({required this.auctionId});

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {'auctionId': auctionId};
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [auctionId];
}
