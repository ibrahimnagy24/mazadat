import 'package:equatable/equatable.dart';

class PreviewAuctionWithdrawalParams extends Equatable {
  final int auctionId;
  final String? reason;
  final String? withdrawalType;
  final Map<String, dynamic>? withdrawalData;

  const PreviewAuctionWithdrawalParams({
    required this.auctionId,
    this.reason,
    this.withdrawalType,
    this.withdrawalData,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'auction_id': auctionId,
    };
    
    if (reason != null) {
      map['reason'] = reason;
    }
    
    if (withdrawalType != null) {
      map['withdrawal_type'] = withdrawalType;
    }
    
    if (withdrawalData != null) {
      map.addAll(withdrawalData!);
    }
    
    return map;
  }

  @override
  List<Object?> get props => [auctionId, reason, withdrawalType, withdrawalData];
}
