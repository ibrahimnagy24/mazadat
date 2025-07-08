import 'package:equatable/equatable.dart';

class AuctionDetailsRouteParams extends Equatable {
  final int auctionId;
  final String primaryImage;

  const AuctionDetailsRouteParams(
      {required this.auctionId, required this.primaryImage});

  Map<String, dynamic> toMap() {
    return {
      'id': auctionId,
      'primaryImage': primaryImage,
    };
  }

  @override
  List<Object?> get props => [auctionId, primaryImage];
}
