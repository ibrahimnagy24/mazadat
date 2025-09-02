import 'bid_event_model.dart';

sealed class PusherState {
  const PusherState();
}

final class PusherInitial extends PusherState {}

final class PusherInitLoading extends PusherState {}

final class PusherInitSuccess extends PusherState {}

final class PusherInitError extends PusherState {
  final String error;
  const PusherInitError(this.error);
}

final class PusherConnectionLoading extends PusherState {}

final class PusherConnectionSuccess extends PusherState {}

final class PusherConnectionError extends PusherState {
  final String error;
  const PusherConnectionError(this.error);
}

final class PusherSubscriptionLoading extends PusherState {}

final class PusherSubscriptionSuccess extends PusherState {}

final class PusherSubscriptionError extends PusherState {
  final String error;
  const PusherSubscriptionError(this.error);
}

final class PusherConnectionStateChanged extends PusherState {
  final PusherConnectionState state;
  const PusherConnectionStateChanged(this.state);
}

final class AuctionBidReceived extends PusherState {
  final int auctionId;
  final BidEventModel bidData;

  const AuctionBidReceived({
    required this.auctionId,
    required this.bidData,
  });
}

final class AuctionEnded extends PusherState {
  final int auctionId;
  const AuctionEnded({required this.auctionId});
}

final class AuctionStarted extends PusherState {
  final int auctionId;
  const AuctionStarted({required this.auctionId});
}

enum PusherConnectionState {
  RECONNECTING,
  DISCONNECTED,
  CONNECTING,
  CONNECTED,
  DISCONNECTING
}
