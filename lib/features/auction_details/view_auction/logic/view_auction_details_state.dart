part of 'view_auction_details_cubit.dart';

sealed class ViewAuctionDetailsState {
  const ViewAuctionDetailsState();
}

final class ViewAuctionDetailsInitial extends ViewAuctionDetailsState {}

final class ViewAuctionDetailsLoading extends ViewAuctionDetailsState {
  const ViewAuctionDetailsLoading();
}

final class ViewAuctionDetailsSuccess extends ViewAuctionDetailsState {
  final ViewAuctionDetailsEntity auctionDetails;
  ViewAuctionDetailsSuccess(this.auctionDetails);
}

final class ViewAuctionDetailsError extends ViewAuctionDetailsState {
  final ErrorEntity error;
  ViewAuctionDetailsError(this.error);
}

final class ViewAuctionDetailsImageChanged extends ViewAuctionDetailsState {
  final int imageIndex;
  const ViewAuctionDetailsImageChanged(this.imageIndex);
}

final class AuctionBidLoading extends ViewAuctionDetailsState {
  const AuctionBidLoading();
}

final class AuctionBidSuccess extends ViewAuctionDetailsState {
  final AuctionBiddingModel auctionBidding;
  const AuctionBidSuccess(this.auctionBidding);
}

final class AuctionBidError extends ViewAuctionDetailsState {
  final ErrorEntity error;
  const AuctionBidError(this.error);
}
