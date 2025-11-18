import '../../../../core/shared/entity/error_entity.dart';
import '../../../auctions/data/entity/auction_entity.dart';

sealed class SearchState {
  const SearchState();
}

final class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchEmpty extends SearchState {
  const SearchEmpty();
}

class SearchSuccess extends SearchState {
  final List<AuctionEntity> auctions;
  final bool isLoading;
  const SearchSuccess({required this.auctions, this.isLoading = false});
}

class SearchError extends SearchState {
  final ErrorEntity error;
  const SearchError(this.error);
}
