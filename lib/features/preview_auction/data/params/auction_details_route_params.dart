import 'package:equatable/equatable.dart';

class PreviewAuctionRouteParams extends Equatable {
  final int auctionId;
  final String primaryImage;

  const PreviewAuctionRouteParams({required this.auctionId, this.primaryImage=''});

  Map<String, dynamic> toMap() {
    return {
      'id': auctionId,
      'primaryImage': primaryImage,
    };
  }

  @override
  List<Object?> get props => [auctionId, primaryImage];
}
