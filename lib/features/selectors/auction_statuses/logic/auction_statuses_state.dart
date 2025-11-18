part of 'auction_statuses_cubit.dart';

sealed class AuctionStatusesState {
  const AuctionStatusesState();
}

final class AuctionStatusesStart extends AuctionStatusesState {}

final class AuctionStatusesEmpty extends AuctionStatusesState {}

final class AuctionStatusesLoading extends AuctionStatusesState {}

final class AuctionStatusesDone extends AuctionStatusesState {
  const AuctionStatusesDone(this.auctionStatuses);
  final List<AuctionStatusEntity> auctionStatuses;
}

final class AuctionStatusesError extends AuctionStatusesState {
  const AuctionStatusesError(this.error);
  final ErrorEntity error;
}

