import '../../../core/shared/entity/error_entity.dart';
import '../../home/data/enum/displayed_types.dart';
import '../data/entity/my_auction_entity.dart';
import '../data/enum/auction_status_type.dart';

sealed class MyAuctionsState {
  const MyAuctionsState();
}

final class MyAuctionsInitial extends MyAuctionsState {}

final class MyAuctionsDisplayedTypeChanged extends MyAuctionsState {
  const MyAuctionsDisplayedTypeChanged({required this.displayedType});
  final HomeDisplayedTypes displayedType;
}

final class MyAuctionsStatusTypeChanged extends MyAuctionsState {
  const MyAuctionsStatusTypeChanged({required this.statusType});
  final AuctionStatusType statusType;
}

final class MyAuctionsLoading extends MyAuctionsState {}

final class MyAuctionsLoaded extends MyAuctionsState {
  const MyAuctionsLoaded(this.auctions);
  final List<MyAuctionEntity> auctions;
}

final class MyAuctionsError extends MyAuctionsState {
  const MyAuctionsError(this.error);
  final ErrorEntity error;
}
