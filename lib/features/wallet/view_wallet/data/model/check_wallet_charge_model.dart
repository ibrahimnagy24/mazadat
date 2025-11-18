import 'package:equatable/equatable.dart';

class CheckWalletChargeModel extends Equatable {
  final String message;
  final String status;

  const CheckWalletChargeModel({required this.message, required this.status});

  @override
  List<Object?> get props => [message, status];

  factory CheckWalletChargeModel.fromJson(Map<String, dynamic> json) {
    return CheckWalletChargeModel(
      message: json['MESSAGE'],
      status: json['STATUS'],
    );
  }
}
