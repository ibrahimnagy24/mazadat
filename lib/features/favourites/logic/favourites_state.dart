import '../../../core/shared/entity/error_entity.dart';
import '../../auctions/data/entity/auction_entity.dart';

sealed class FavouritesState {
  const FavouritesState();
}

final class FavouritesInitial extends FavouritesState {
  const FavouritesInitial();
}

class FavouritesLoading extends FavouritesState {
  const FavouritesLoading();
}

class FavouritesEmpty extends FavouritesState {
  const FavouritesEmpty();
}

class FavouritesSuccess extends FavouritesState {
  final List<AuctionEntity> auctions;
  final bool isLoading;
  const FavouritesSuccess({required this.auctions, this.isLoading = false});
}

class FavouritesError extends FavouritesState {
  final ErrorEntity error;
  const FavouritesError(this.error);
}

class FavouritesUpdated extends FavouritesState {
  final Set<int> favouriteIds;
  const FavouritesUpdated({required this.favouriteIds});
}
