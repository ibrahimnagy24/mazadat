import 'package:equatable/equatable.dart';

class CheckInsurancePaymentParams extends Equatable {
  final int bundleId;
  final int paymentTransactionId;

  const CheckInsurancePaymentParams({
    required this.bundleId,
    required this.paymentTransactionId,
  });

  Map<String, dynamic> returnedMap() {
    return {
      'bundleId': bundleId,
      'paymentTransactionId': paymentTransactionId,
    };
  }

  @override
  List<Object> get props => [bundleId, paymentTransactionId];
}
