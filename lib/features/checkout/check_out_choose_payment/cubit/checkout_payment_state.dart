import '../../../../core/shared/entity/error_entity.dart';
import '../data/entity/checkout_payment_entity.dart';
import '../data/entity/confirm_checkout_entity.dart';
import '../data/entity/payment_status_entity.dart';

sealed class CheckoutPaymentState {
  const CheckoutPaymentState();
}

final class CheckoutPaymentInitial extends CheckoutPaymentState {
  const CheckoutPaymentInitial();
}

final class CheckoutPaymentLoading extends CheckoutPaymentState {
  const CheckoutPaymentLoading();
}

final class CheckoutPaymentLoaded extends CheckoutPaymentState {
  final CheckoutPaymentEntity paymentMethods;
  const CheckoutPaymentLoaded(this.paymentMethods);
}

final class CheckoutPaymentError extends CheckoutPaymentState {
  final ErrorEntity error;
  const CheckoutPaymentError(this.error);
}

// States for selecting payment method
final class SelectPaymentMethodLoading extends CheckoutPaymentState {
  const SelectPaymentMethodLoading();
}

final class SelectPaymentMethodSuccess extends CheckoutPaymentState {
  final String message;
  const SelectPaymentMethodSuccess(this.message);
}

final class SelectPaymentMethodError extends CheckoutPaymentState {
  final ErrorEntity error;
  const SelectPaymentMethodError(this.error);
}

// States for confirm checkout
final class ConfirmCheckoutLoading extends CheckoutPaymentState {
  const ConfirmCheckoutLoading();
}

final class ConfirmCheckoutSuccess extends CheckoutPaymentState {
  final ConfirmCheckoutEntity confirmCheckout;
  const ConfirmCheckoutSuccess(this.confirmCheckout);
}

final class ConfirmCheckoutError extends CheckoutPaymentState {
  final ErrorEntity error;
  const ConfirmCheckoutError(this.error);
}

// States for payment status
final class PaymentStatusLoading extends CheckoutPaymentState {
  const PaymentStatusLoading();
}

final class PaymentStatusSuccess extends CheckoutPaymentState {
  final PaymentStatusEntity paymentStatus;
  const PaymentStatusSuccess(this.paymentStatus);
}

final class PaymentStatusError extends CheckoutPaymentState {
  final ErrorEntity error;
  const PaymentStatusError(this.error);
}
