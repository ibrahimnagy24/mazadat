import 'package:equatable/equatable.dart';

class CheckWalletChargeParams extends Equatable {
  final dynamic paymentTransactionId;

  const CheckWalletChargeParams({required this.paymentTransactionId});

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {'paymentTransactionId': paymentTransactionId};
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [paymentTransactionId];
}
