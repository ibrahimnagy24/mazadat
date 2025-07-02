import '../../../core/shared/entity/error_entity.dart';
import '../data/entity/auction_entity.dart';

sealed class AuctionsState {
  const AuctionsState();
}

final class AuctionsInitial extends AuctionsState {
  const AuctionsInitial();
}

class AuctionsLoading extends AuctionsState {
  const AuctionsLoading();
}

class AuctionsEmpty extends AuctionsState {
  const AuctionsEmpty();
}

class AuctionsSuccess extends AuctionsState {
  final List<AuctionEntity> auctions;
  final bool isLoading;
  const AuctionsSuccess({required this.auctions, this.isLoading = false});
}

class AuctionsError extends AuctionsState {
  final ErrorEntity error;
  const AuctionsError(this.error);
}
