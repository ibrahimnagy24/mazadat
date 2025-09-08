import 'package:equatable/equatable.dart';

class AuctionBiddingModel extends Equatable {
  final String message;
  final dynamic code;
  final String status;

  const AuctionBiddingModel({
    required this.message,
    required this.code,
    required this.status,
  });

  factory AuctionBiddingModel.fromJson(Map<String, dynamic> json) {
    return AuctionBiddingModel(
      message: json['MESSAGE'],
      code: json['CODE'],
      status: json['STATUS'],
    );
  }

  @override
  List<Object?> get props => [message, code, status];
}
