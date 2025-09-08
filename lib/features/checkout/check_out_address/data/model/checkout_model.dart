import 'package:equatable/equatable.dart';

class CheckoutModel extends Equatable {
  final String message;

  const CheckoutModel({required this.message});

  @override
  List<Object?> get props => [message];

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(message: json['MESSAGE']);
  }
}
