import 'package:equatable/equatable.dart';

class PreviewAuctionBiddingParams extends Equatable {
  final int auctionId;
  final double amount;
  final String? biddingType;
  final bool? isAutoBid;
  final Map<String, dynamic>? biddingData;

  const PreviewAuctionBiddingParams({
    required this.auctionId,
    required this.amount,
    this.biddingType,
    this.isAutoBid,
    this.biddingData,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'auction_id': auctionId,
      'amount': amount,
    };
    
    if (biddingType != null) {
      map['bidding_type'] = biddingType;
    }
    
    if (isAutoBid != null) {
      map['is_auto_bid'] = isAutoBid;
    }
    
    if (biddingData != null) {
      map.addAll(biddingData!);
    }
    
    return map;
  }

  @override
  List<Object?> get props => [auctionId, amount, biddingType, isAutoBid, biddingData];
}
