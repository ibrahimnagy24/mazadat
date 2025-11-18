import 'package:equatable/equatable.dart';

class ConfirmCheckoutEntity extends Equatable {
  final String formLink;
  final String payment;
  final String message;
  final String code;
  final String status;
  final String transactionId;

  const ConfirmCheckoutEntity({
    required this.formLink,
    required this.payment,
    required this.message,
    required this.code,
    required this.status,
    required this.transactionId,
  });

  @override
  List<Object?> get props => [
        formLink,
        payment,
        message,
        code,
        status,
        transactionId,
      ];
}
