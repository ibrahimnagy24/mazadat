import 'package:equatable/equatable.dart';

class CheckoutSummaryRouteParams extends Equatable {
  final int auctionId;

  const CheckoutSummaryRouteParams({required this.auctionId});

  @override
  List<Object?> get props => [auctionId];
}
