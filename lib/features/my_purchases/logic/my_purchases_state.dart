import '../../../core/shared/entity/error_entity.dart';
import '../data/entity/my_purchase_content_entity.dart';

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
  final List<MyPurchaseContentEntity> purchases;
  final bool isLoading;
  const MyPurchasesSuccess({required this.purchases, this.isLoading = false});
}

class MyPurchasesError extends MyPurchasesState {
  final ErrorEntity error;
  const MyPurchasesError(this.error);
}
