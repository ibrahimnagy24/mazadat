part of 'view_auction_cubit.dart';

sealed class AuctionDetailsState extends Equatable {
  const AuctionDetailsState();

  @override
  List<Object> get props => [];
}

class AuctionDetailsInitial extends AuctionDetailsState {}

class AuctionDetailsLoading extends AuctionDetailsState {
  const AuctionDetailsLoading();
}

class AuctionDetailsEmpty extends AuctionDetailsState {
  const AuctionDetailsEmpty();
}

class AuctionDetailsSuccess extends AuctionDetailsState {
  final AuctionDetailsModel AuctionDetails;
  const AuctionDetailsSuccess({required this.AuctionDetails});
}

class AuctionDetailsError extends AuctionDetailsState {
  final ErrorEntity error;
  const AuctionDetailsError(this.error);
}

class AuctionSwitchBiddingLoading extends AuctionDetailsState {
  const AuctionSwitchBiddingLoading();
}

class AuctionSwitchBiddingError extends AuctionDetailsState {
  final ErrorEntity error;
  const AuctionSwitchBiddingError(this.error);
}

class AuctionFirstBiddingSuccess extends AuctionDetailsState {
  const AuctionFirstBiddingSuccess();
}
