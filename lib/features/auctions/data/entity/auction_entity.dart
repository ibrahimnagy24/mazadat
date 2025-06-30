import 'package:equatable/equatable.dart';

class AuctionEntity extends Equatable {
  final String auctionTypeName;
  final String image;
  final String productName;
  final String productDescription;
  final dynamic openingPrice;
  final dynamic insurancePrice;
  final String endDate;
  final String auctionDuration;
  final int id;

  const AuctionEntity({
    required this.auctionTypeName,
    required this.image,
    required this.productName,
    required this.productDescription,
    required this.openingPrice,
    required this.insurancePrice,
    required this.endDate,
    required this.auctionDuration,
    required this.id,
  });

  @override
  List<Object?> get props => [
        auctionTypeName,
        image,
        productName,
        productDescription,
        openingPrice,
        insurancePrice,
        endDate,
        auctionDuration,
        id,
      ];
}
