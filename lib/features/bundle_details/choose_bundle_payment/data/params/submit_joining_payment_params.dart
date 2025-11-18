import 'package:equatable/equatable.dart';

class SubmitJoiningPaymentParams extends Equatable {
  final int bundleId;
  final int paymentType;

  const SubmitJoiningPaymentParams({
    required this.bundleId,
    required this.paymentType,
  });

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'bundleId': bundleId,
      'paymentType': paymentType,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [bundleId, paymentType];
}
