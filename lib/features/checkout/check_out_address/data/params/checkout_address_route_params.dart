import 'package:equatable/equatable.dart';

class CheckoutAddressRouteParams extends Equatable {
  final int auctionId;

  const CheckoutAddressRouteParams({required this.auctionId});

  @override
  List<Object?> get props => [auctionId];
}
