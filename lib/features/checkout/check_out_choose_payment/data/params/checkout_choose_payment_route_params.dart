import 'package:equatable/equatable.dart';

import '../../../../auction_details/view_auction/logic/view_auction_details_cubit.dart';

class CheckoutChoosePaymentRouteParams extends Equatable {
  final int auctionId;
  final ViewAuctionDetailsCubit? cubit;

  const CheckoutChoosePaymentRouteParams({
    required this.auctionId,
    this.cubit,
  });

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {'auctionId': auctionId};
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [auctionId];
}
