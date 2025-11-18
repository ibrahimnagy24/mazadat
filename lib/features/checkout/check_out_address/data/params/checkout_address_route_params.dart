import 'package:equatable/equatable.dart';
import '../../../../auction_details/view_auction/logic/view_auction_details_cubit.dart';

class CheckoutAddressRouteParams extends Equatable {
  final int auctionId;
  final ViewAuctionDetailsCubit? cubit;

  const CheckoutAddressRouteParams({required this.auctionId, this.cubit});

  @override
  List<Object?> get props => [auctionId, cubit];
}
