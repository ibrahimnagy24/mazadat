import '../entity/auction_types_entity.dart';

class AuctionStatusModel extends AuctionStatusesEntity {
  const AuctionStatusModel({
    required super.code,
    required super.name,
  });

  factory AuctionStatusModel.fromJson(Map<String, dynamic> json) =>
      AuctionStatusModel(
        code: json['code'],
        name: json['name'],
      );
}
