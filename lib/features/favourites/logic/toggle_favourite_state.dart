import '../../../core/shared/entity/error_entity.dart';
import '../../auctions/data/entity/auction_entity.dart';

sealed class ToggleFavouriteState {
  const ToggleFavouriteState();
}

final class ToggleFavouriteInitial extends ToggleFavouriteState {
  const ToggleFavouriteInitial();
}

class ToggleFavouriteSuccess extends ToggleFavouriteState {
  const ToggleFavouriteSuccess();
}
