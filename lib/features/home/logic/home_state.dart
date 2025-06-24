import '../../../core/shared/entity/error_entity.dart';
import '../data/entity/home_auction_entity.dart';

sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeTitleTypeChanged extends HomeState {}

class HomeFeaturedAuctionLoading extends HomeState {
  const HomeFeaturedAuctionLoading();
}

class HomeFeaturedAuctionSuccess extends HomeState {
  final List<HomeAuctionEntity> auctions;
  const HomeFeaturedAuctionSuccess(this.auctions);
}

class HomeFeaturedAuctionError extends HomeState {
  final ErrorEntity error;
  const HomeFeaturedAuctionError(this.error);
}

class HomeInProgressAuctionLoading extends HomeState {
  const HomeInProgressAuctionLoading();
}

class HomeInProgressAuctionSuccess extends HomeState {
  final List<HomeAuctionEntity> auctions;
  const HomeInProgressAuctionSuccess(this.auctions);
}

class HomeInProgressAuctionError extends HomeState {
  final ErrorEntity error;
  const HomeInProgressAuctionError(this.error);
}

class HomeUpComingAuctionLoading extends HomeState {
  const HomeUpComingAuctionLoading();
}

class HomeUpComingAuctionSuccess extends HomeState {
  final List<HomeAuctionEntity> auctions;
  const HomeUpComingAuctionSuccess(this.auctions);
}

class HomeUpComingAuctionError extends HomeState {
  final ErrorEntity error;
  const HomeUpComingAuctionError(this.error);
}
