import 'package:equatable/equatable.dart';

class VisitorModel extends Equatable {
  final String message;
  final String status;

  const VisitorModel({
    required this.message,
    required this.status,
  });

  @override
  List<Object?> get props => [message, status];

  factory VisitorModel.fromJson(Map<String, dynamic> json) => VisitorModel(
        message: json['MESSAGE'],
        status: json['STATUS'],
      );
}
