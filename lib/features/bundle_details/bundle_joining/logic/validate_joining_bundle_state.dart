import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/shared/models/auction_policy_model.dart';

sealed class ValidateJoiningBundleState {
  const ValidateJoiningBundleState();
}

class ValidateJoiningBundleInitial extends ValidateJoiningBundleState {}

class ValidateJoiningBundleLoading extends ValidateJoiningBundleState {}

class ValidateJoiningBundleSuccess extends ValidateJoiningBundleState {
  final AuctionPolicyModel data;
  const ValidateJoiningBundleSuccess({required this.data});
}

class ValidateJoiningBundleError extends ValidateJoiningBundleState {
  final ErrorEntity error;
  const ValidateJoiningBundleError(this.error);
}

class SubmitJoiningBundleLoading extends ValidateJoiningBundleState {}

class SubmitJoiningBundleSuccess extends ValidateJoiningBundleState {
  final String message;
  final String? transactionId;
  final String? formLink;
  
  const SubmitJoiningBundleSuccess(
    this.message, {
    this.transactionId,
    this.formLink,
  });
}

class SubmitJoiningBundleError extends ValidateJoiningBundleState {
  final ErrorEntity error;
  const SubmitJoiningBundleError(this.error);
}

class CheckInsurancePaymentLoading extends ValidateJoiningBundleState {}

class CheckInsurancePaymentSuccess extends ValidateJoiningBundleState {
  final String message;
  const CheckInsurancePaymentSuccess(this.message);
}

class CheckInsurancePaymentError extends ValidateJoiningBundleState {
  final ErrorEntity error;
  const CheckInsurancePaymentError(this.error);
}
