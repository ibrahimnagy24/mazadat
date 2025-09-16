import 'package:equatable/equatable.dart';

class ContactUsResponseEntity extends Equatable {
  const ContactUsResponseEntity({
    required this.message,
    required this.code,
    required this.status,
  });

  final String message;
  final String code;
  final String status;

  @override
  List<Object?> get props => [message, code, status];
}
