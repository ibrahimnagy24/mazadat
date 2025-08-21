import 'package:equatable/equatable.dart';

class PreviewAuctionValidationParams extends Equatable {
  final int auctionId;
  final String? userId;
  final String? validationType;
  final Map<String, dynamic>? validationData;

  const PreviewAuctionValidationParams({
    required this.auctionId,
    this.userId,
    this.validationType,
    this.validationData,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'auction_id': auctionId,
    };
    
    if (userId != null) {
      map['user_id'] = userId;
    }
    
    if (validationType != null) {
      map['validation_type'] = validationType;
    }
    
    if (validationData != null) {
      map.addAll(validationData!);
    }
    
    return map;
  }

  @override
  List<Object?> get props => [auctionId, userId, validationType, validationData];
}
