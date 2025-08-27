part of 'auction_pusher_cubit.dart';

sealed class AuctionPusherState {
  const AuctionPusherState();
}

final class AuctionPusherInitial extends AuctionPusherState {}

//--------//--------//--------//--------//--------//--------
class ChannelInitLoading extends AuctionPusherState {}

class ChannelInitSuccess extends AuctionPusherState {}

class ChannelInitError extends AuctionPusherState {
  final String error;
  const ChannelInitError(this.error);
}

//--------//--------//--------//--------//--------//--------
class ChannelConnectionLoading extends AuctionPusherState {
  const ChannelConnectionLoading();
}

class ChannelConnectionSuccess extends AuctionPusherState {
  const ChannelConnectionSuccess();
}

class ChannelConnectionError extends AuctionPusherState {
  final String error;
  const ChannelConnectionError(this.error);
}

//--------//--------//--------//--------//--------//--------
class ChannelSubscribedLoading extends AuctionPusherState {
  const ChannelSubscribedLoading();
}

class ChannelSubscribedSuccess extends AuctionPusherState {
  const ChannelSubscribedSuccess();
}

class ChannelSubscribedError extends AuctionPusherState {
  final String error;
  const ChannelSubscribedError(this.error);
}

//--------//--------//--------//--------//--------//--------
class RoomCurrentState extends AuctionPusherState {
  RoomCurrentState(this.currentState);
  final PusherStateEnum currentState;
}

//--------//--------//--------//--------//--------//--------

//--------//--------//--------//--------//--------//--------

class BiddingState extends AuctionPusherState {
  final AuctionPusherModel details;
  const BiddingState(this.details);
}
