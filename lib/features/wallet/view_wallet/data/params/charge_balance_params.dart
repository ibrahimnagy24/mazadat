import 'package:equatable/equatable.dart';

class ChargeBalanceParams extends Equatable {
  final dynamic amount;
  final int paymentId;

  const ChargeBalanceParams({
    required this.amount,
    required this.paymentId,
  });

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {'amount': amount, 'paymentType': paymentId};
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [amount, paymentId];
}
