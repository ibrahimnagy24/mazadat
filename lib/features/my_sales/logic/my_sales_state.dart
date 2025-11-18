import '../../../core/shared/entity/error_entity.dart';
import '../data/entity/auction_entity.dart';
import '../data/enum/display_types.dart';

sealed class MySalesState {
  const MySalesState();
}

final class MySalesInitial extends MySalesState {
  const MySalesInitial();
}

class MySalesLoading extends MySalesState {
  const MySalesLoading();
}

class MySalesSuccess extends MySalesState {
  final List<AuctionEntity> auctions;
  const MySalesSuccess({required this.auctions});
}

class MySalesError extends MySalesState {
  final ErrorEntity error;
  const MySalesError(this.error);
}

final class MySalesDisplayTypeChanged extends MySalesState {
  final MySalesDisplayTypes displayType;
  const MySalesDisplayTypeChanged({required this.displayType});
}

class MySalesSearchLoading extends MySalesState {
  const MySalesSearchLoading();
}

class MySalesSearchSuccess extends MySalesState {
  final List<AuctionEntity> searchResults;
  const MySalesSearchSuccess({required this.searchResults});
}

class MySalesSearchError extends MySalesState {
  final ErrorEntity error;
  const MySalesSearchError(this.error);
}

class MySalesSearchEmpty extends MySalesState {
  const MySalesSearchEmpty();
}
