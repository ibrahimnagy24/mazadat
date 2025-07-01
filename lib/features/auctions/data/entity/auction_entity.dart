import 'package:equatable/equatable.dart';

import '../enums/auction_enums.dart';

class AuctionEntity extends Equatable {
  final AuctionType auctionType;
  final String auctionStatus;
  final String image;
  final String productName;
  final String productDescription;
  final dynamic openingPrice;
  final dynamic insurancePrice;
  final DateTime startDate, endDate;
  final String auctionDuration;
  final int id;
  final bool isFav;

  const AuctionEntity({
    required this.id,
    required this.auctionStatus,
    required this.auctionType,
    required this.image,
    required this.productName,
    required this.productDescription,
    required this.openingPrice,
    required this.insurancePrice,
    required this.startDate,
    required this.endDate,
    required this.auctionDuration,
    required this.isFav,
  });

  @override
  List<Object?> get props => [
        auctionType,
        auctionStatus,
        image,
        productName,
        productDescription,
        openingPrice,
        insurancePrice,
        startDate,
        endDate,
        auctionDuration,
        id,
        isFav,
      ];
}
