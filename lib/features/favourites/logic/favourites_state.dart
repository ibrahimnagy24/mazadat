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

class FavouritesSuccess extends FavouritesState {
  final List<AuctionEntity> auctions;
  const FavouritesSuccess(this.auctions);
}

class FavouritesError extends FavouritesState {
  final ErrorEntity error;
  const FavouritesError(this.error);
}
