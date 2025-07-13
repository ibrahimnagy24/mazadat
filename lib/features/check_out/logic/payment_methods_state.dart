import '../../../core/shared/entity/error_entity.dart';
import '../data/model/payment_model.dart';

sealed class PaymentMethodsState {
  const PaymentMethodsState();
}

final class PaymentMethodsInitial extends PaymentMethodsState {
  const PaymentMethodsInitial();
}

final class PaymentMethodsEmpty extends PaymentMethodsState {
  const PaymentMethodsEmpty();
}

class PaymentMethodsLoading extends PaymentMethodsState {
  const PaymentMethodsLoading();
}

class PaymentMethodsSuccess extends PaymentMethodsState {
  final List<PaymentModel> payments;
  const PaymentMethodsSuccess({required this.payments});
}

class PaymentMethodsError extends PaymentMethodsState {
  final ErrorEntity error;
  const PaymentMethodsError(this.error);
}
