import '../../../../core/shared/entity/error_entity.dart';
import '../data/entity/checkout_summary_entity.dart';
import '../data/entity/validate_summary_entity.dart';

sealed class CheckoutSummaryState {
  const CheckoutSummaryState();
}

final class CheckoutSummaryInitial extends CheckoutSummaryState {}

final class CheckoutSummaryLoading extends CheckoutSummaryState {}

final class CheckoutSummaryLoaded extends CheckoutSummaryState {
  final CheckoutSummaryEntity checkoutSummary;
  const CheckoutSummaryLoaded(this.checkoutSummary);
}

final class CheckoutSummaryError extends CheckoutSummaryState {
  final ErrorEntity error;
  const CheckoutSummaryError(this.error);
}

final class ValidateSummaryLoading extends CheckoutSummaryState {}

final class ValidateSummaryLoaded extends CheckoutSummaryState {
  final ValidateSummaryEntity validateSummary;
  const ValidateSummaryLoaded(this.validateSummary);
}

final class ValidateSummaryError extends CheckoutSummaryState {
  final ErrorEntity error;
  const ValidateSummaryError(this.error);
}

final class AutionCheckoutTimeFinished extends CheckoutSummaryState {}
