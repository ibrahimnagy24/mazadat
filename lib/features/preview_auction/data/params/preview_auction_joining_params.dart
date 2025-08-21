import 'package:equatable/equatable.dart';

class PreviewAuctionJoiningParams extends Equatable {
  final int auctionId;
  final String? userToken;
  final Map<String, dynamic>? additionalData;

  const PreviewAuctionJoiningParams({
    required this.auctionId,
    this.userToken,
    this.additionalData,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'auction_id': auctionId,
    };
    
    if (userToken != null) {
      map['user_token'] = userToken;
    }
    
    if (additionalData != null) {
      map.addAll(additionalData!);
    }
    
    return map;
  }

  @override
  List<Object?> get props => [auctionId, userToken, additionalData];
}
