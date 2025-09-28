import '../../../../core/shared/entity/error_entity.dart';
import '../data/entity/bundle_payment_entity.dart';
import '../data/entity/bundle_payment_status_entity.dart';
import '../data/entity/submit_joining_response_entity.dart';

sealed class BundlePaymentState {
  const BundlePaymentState();
}

final class BundlePaymentInitial extends BundlePaymentState {
  const BundlePaymentInitial();
}

final class BundlePaymentLoading extends BundlePaymentState {
  const BundlePaymentLoading();
}

final class BundlePaymentLoaded extends BundlePaymentState {
  final BundlePaymentEntity paymentMethods;
  const BundlePaymentLoaded(this.paymentMethods);
}

final class BundlePaymentError extends BundlePaymentState {
  final ErrorEntity error;
  const BundlePaymentError(this.error);
}

// States for selecting payment method
final class SubmitJoiningLoading extends BundlePaymentState {
  const SubmitJoiningLoading();
}

final class SubmitJoiningSuccess extends BundlePaymentState {
  final SubmitJoiningResponseEntity entity;
  const SubmitJoiningSuccess(this.entity);
}

final class SubmitJoiningError extends BundlePaymentState {
  final ErrorEntity error;
  const SubmitJoiningError(this.error);
}

// States for bundle payment status
final class BundlePaymentStatusLoading extends BundlePaymentState {
  const BundlePaymentStatusLoading();
}

final class BundlePaymentStatusSuccess extends BundlePaymentState {
  final BundlePaymentStatusEntity paymentStatus;
  const BundlePaymentStatusSuccess(this.paymentStatus);
}

final class BundlePaymentStatusError extends BundlePaymentState {
  final ErrorEntity error;
  const BundlePaymentStatusError(this.error);
}
