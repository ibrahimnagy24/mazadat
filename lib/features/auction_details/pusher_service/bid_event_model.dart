import 'package:equatable/equatable.dart';

class BidEventModel extends Equatable {
  final num currentAmount;
  final int userId;

  const BidEventModel({
    required this.currentAmount,
    required this.userId,
  });

  factory BidEventModel.fromJson(Map<String, dynamic> json) {
    return BidEventModel(
      currentAmount: num.parse(json['currentAmount'].toString()),
      userId: int.parse(json['userId'].toString()),
    );
  }

  @override
  List<Object?> get props => [currentAmount, userId];
}
