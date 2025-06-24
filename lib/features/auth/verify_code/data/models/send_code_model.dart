import 'package:equatable/equatable.dart';

class SendCodeModel extends Equatable {
  final String message;
  final String code;
  final String phone;
  final String otp;

  const SendCodeModel({
    required this.message,
    required this.code,
    required this.phone,
    required this.otp,
  });

  factory SendCodeModel.fromJson(Map<String, dynamic> json) => SendCodeModel(
        message: json['MESSAGE'],
        code: json['CODE'],
        phone: json['PHONE'],
        otp: json['OTP'],
      );

  @override
  List<Object?> get props => [message, code, phone, otp];
}
