import 'package:equatable/equatable.dart';

class ContactUsRequestParams extends Equatable {
  const ContactUsRequestParams({
    required this.name,
    required this.phone,
    required this.email,
    required this.message,
    required this.type,
  });

  final String name;
  final String phone;
  final String email;
  final String message;
  final int type;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'message': message,
      'type': type,
    };
  }

  @override
  List<Object?> get props => [name, phone, email, message, type];
}
