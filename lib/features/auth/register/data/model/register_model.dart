import 'package:equatable/equatable.dart';

class RegisterModel extends Equatable {
  const RegisterModel({
    required this.message,
    required this.status,
    required this.statusCode,
  });
  final String message;
  final dynamic statusCode;
  final String status;

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      message: json['MESSAGE'],
      status: json['STATUS'],
      statusCode: json['CODE'],
    );
  }

  @override
  List<Object?> get props => [message, statusCode, status];
}
