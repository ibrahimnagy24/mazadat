import 'package:equatable/equatable.dart';

class HomeAuctionEntity extends Equatable {
  final String auctionTypeName;
  final String image;
  final String productName;
  final String productDescription;
  final dynamic openingPrice;
  final dynamic insurancePrice;
  final String endDate;
  final String acutionDuration;
  final int id;

  const HomeAuctionEntity({
    required this.auctionTypeName,
    required this.image,
    required this.productName,
    required this.productDescription,
    required this.openingPrice,
    required this.insurancePrice,
    required this.endDate,
    required this.acutionDuration,
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
        acutionDuration,
        id,
      ];
}
