import '../entity/auction_status_entity.dart';

class AuctionStatusModel extends AuctionStatusEntity {
  const AuctionStatusModel({
    required super.value,
    required super.label,
  });

  factory AuctionStatusModel.fromJson(Map<String, dynamic> json) =>
      AuctionStatusModel(
        label: json['label'],
        value: json['value'],
      );
}
