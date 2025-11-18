import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/enums.dart';

class AuctionBidParams extends Equatable {
  final int auctionId;
  final BiddingMethod biddingMethod;
  final double? maxBiddingValue;

  const AuctionBidParams({
    required this.auctionId,
    required this.biddingMethod,
    this.maxBiddingValue,
  });

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'auctionId': auctionId,
      'biddingMethod': biddingMethod.name.toUpperCase(),
      'maxBiddingValue':
          biddingMethod == BiddingMethod.auto ? maxBiddingValue : null,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [auctionId, biddingMethod, maxBiddingValue];
}
