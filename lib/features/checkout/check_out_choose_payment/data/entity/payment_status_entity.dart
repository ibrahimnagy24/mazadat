import 'package:equatable/equatable.dart';

class PaymentStatusEntity extends Equatable {
  final int shipmentId;
  final String message;
  final String status;
  final String code;

  const PaymentStatusEntity({
    required this.shipmentId,
    required this.message,
    required this.status,
    required this.code,
  });

  @override
  List<Object?> get props => [
        shipmentId,
        message,
        status,
        code,
      ];
}
