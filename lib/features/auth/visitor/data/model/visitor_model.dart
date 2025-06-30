import 'package:equatable/equatable.dart';

class VisitorModel extends Equatable {
  final String message;
  final String status;
  final String token;




  const VisitorModel({
    required this.message,
    required this.status,
    required this.token,
  });

  @override
  List<Object?> get props => [message, status, token];

  factory VisitorModel.fromJson(Map<String, dynamic> json) => VisitorModel(
        message: json['MESSAGE'],
        status: json['STATUS'],
        token: json['TOKEN'] ?? '',
      );
}
