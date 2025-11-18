import '../../../../core/shared/entity/error_entity.dart';
import '../../../auctions/data/entity/auction_entity.dart';

sealed class SearchResultState {
  const SearchResultState();
}

final class SearchResultInitial extends SearchResultState {
  const SearchResultInitial();
}

class SearchResultLoading extends SearchResultState {
  const SearchResultLoading();
}

class SearchResultEmpty extends SearchResultState {
  const SearchResultEmpty();
}

class SearchResultSuccess extends SearchResultState {
  final List<AuctionEntity> auctions;
  final bool isLoading;
  const SearchResultSuccess({required this.auctions, this.isLoading = false});
}

class SearchResultError extends SearchResultState {
  final ErrorEntity error;
  const SearchResultError(this.error);
}
