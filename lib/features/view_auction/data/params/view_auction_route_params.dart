import 'package:equatable/equatable.dart';

class ViewAuctionRouteParams extends Equatable {
  final String auctionId;
  const ViewAuctionRouteParams({required this.auctionId});

  Map<String, String> toMap() {
    return {
      'auctionId': auctionId,
    };
  }

  @override
  List<Object?> get props => [auctionId];
}
