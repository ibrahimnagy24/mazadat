import 'package:equatable/equatable.dart';

class SubmitJoiningResponseEntity extends Equatable {
  final String formLink;
  final String message;
  final String code;
  final String status;
  final String transactionId;

  const SubmitJoiningResponseEntity({
    required this.formLink,
    required this.message,
    required this.code,
    required this.status,
    required this.transactionId,
  });

  @override
  List<Object?> get props => [
        formLink,
        message,
        code,
        status,
        transactionId,
      ];
}
