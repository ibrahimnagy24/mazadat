import 'package:equatable/equatable.dart';

class ChargeBalanceModel extends Equatable {
  final String message;
  final String status;
  final dynamic paymentTransactionId;
  const ChargeBalanceModel({
    required this.message,
    required this.status,
    required this.paymentTransactionId,
  });

  factory ChargeBalanceModel.fromJson(Map<String, dynamic> json) {
    return ChargeBalanceModel(
      message: json['MESSAGE'],
      status: json['STATUS'],
      paymentTransactionId: json['TRANSACTION_ID'],
    );
  }

  @override
  List<Object?> get props => [message, status, paymentTransactionId];
}
