import '../../../core/shared/entity/error_entity.dart';
import '../../auctions/data/entity/auction_entity.dart';

sealed class MySalesState {
  const MySalesState();
}

final class MySalesInitial extends MySalesState {
  const MySalesInitial();
}

final class MySalesEmpty extends MySalesState {
  const MySalesEmpty();
}

class MySalesLoading extends MySalesState {
  const MySalesLoading();
}

class MySalesSuccess extends MySalesState {
  final List<AuctionEntity> auctions;
  final bool isLoading;
  const MySalesSuccess({required this.auctions, this.isLoading = false});
}

class MySalesError extends MySalesState {
  final ErrorEntity error;
  const MySalesError(this.error);
}
