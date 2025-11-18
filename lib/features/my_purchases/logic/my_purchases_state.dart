import '../../../core/shared/entity/error_entity.dart';
import '../data/entity/shipment_entity.dart';
import '../data/enum/display_types.dart';

sealed class MyPurchasesState {
  const MyPurchasesState();
}

final class MyPurchasesInitial extends MyPurchasesState {
  const MyPurchasesInitial();
}

class MyPurchasesLoading extends MyPurchasesState {
  const MyPurchasesLoading();
}

class MyPurchasesSuccess extends MyPurchasesState {
  final List<ShipmentEntity> shipments;
  const MyPurchasesSuccess({required this.shipments});
}

class MyPurchasesError extends MyPurchasesState {
  final ErrorEntity error;
  const MyPurchasesError(this.error);
}

final class MyPurchasesDisplayTypeChanged extends MyPurchasesState {
  final MyPurchasesDisplayTypes displayType;
  const MyPurchasesDisplayTypeChanged({required this.displayType});
}

class MyPurchasesSearchLoading extends MyPurchasesState {
  const MyPurchasesSearchLoading();
}

class MyPurchasesSearchSuccess extends MyPurchasesState {
  final List<ShipmentEntity> searchResults;
  const MyPurchasesSearchSuccess({required this.searchResults});
}

class MyPurchasesSearchError extends MyPurchasesState {
  final ErrorEntity error;
  const MyPurchasesSearchError(this.error);
}

class MyPurchasesSearchEmpty extends MyPurchasesState {
  const MyPurchasesSearchEmpty();
}
