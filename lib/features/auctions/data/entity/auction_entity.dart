import 'package:equatable/equatable.dart';

import '../enums/auction_enums.dart';

class AuctionEntity extends Equatable {
  final AuctionType auctionType;
  final String auctionStatus;
  final String image;
  final String name;
  final String description;
  final dynamic openingPrice;
  final dynamic insurancePrice;
  final DateTime startDate, endDate;
  final int id;
  final int? searchId;
  final bool isFav;

  const AuctionEntity({
    required this.id,
    required this.searchId,
    required this.auctionStatus,
    required this.auctionType,
    required this.image,
    required this.name,
    required this.description,
    required this.openingPrice,
    required this.insurancePrice,
    required this.startDate,
    required this.endDate,
    required this.isFav,
  });

  @override
  List<Object?> get props => [
        id,
        searchId,
        auctionType,
        auctionStatus,
        image,
        name,
        description,
        openingPrice,
        insurancePrice,
        startDate,
        endDate,
        isFav,
      ];
}
