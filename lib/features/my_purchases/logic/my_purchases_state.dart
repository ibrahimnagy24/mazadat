import '../../../core/shared/entity/error_entity.dart';
import '../../auctions/data/entity/auction_entity.dart';

sealed class MyPurchasesState {
  const MyPurchasesState();
}

final class MyPurchasesInitial extends MyPurchasesState {
  const MyPurchasesInitial();
}

final class MyPurchasesEmpty extends MyPurchasesState {
  const MyPurchasesEmpty();
}

class MyPurchasesLoading extends MyPurchasesState {
  const MyPurchasesLoading();
}

class MyPurchasesSuccess extends MyPurchasesState {
  final List<AuctionEntity> auctions;
  final bool isLoading;
  const MyPurchasesSuccess({required this.auctions, this.isLoading = false});
}

class MyPurchasesError extends MyPurchasesState {
  final ErrorEntity error;
  const MyPurchasesError(this.error);
}
