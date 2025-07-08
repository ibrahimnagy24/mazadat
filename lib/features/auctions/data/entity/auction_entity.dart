import 'package:equatable/equatable.dart';

import '../enums/auction_enums.dart';

class AuctionEntity extends Equatable {
  final AuctionType auctionType;
  final String auctionStatus;
  final String primaryPhoto;
  final String name;
  final String description;
  final dynamic openingPrice;
  final dynamic insurancePrice;
  final DateTime startDate, endDate;
  final int id;
  final int? searchId;
  final bool isFav;
  final String? orderNumber;

  const AuctionEntity({
    required this.id,
    required this.searchId,
    required this.auctionStatus,
    required this.auctionType,
    required this.primaryPhoto,
    required this.name,
    required this.description,
    required this.openingPrice,
    required this.insurancePrice,
    required this.startDate,
    required this.endDate,
    required this.isFav,
     this.orderNumber,
  });

  @override
  List<Object?> get props => [
        id,
        searchId,
        auctionType,
        auctionStatus,
        primaryPhoto,
        name,
        description,
        openingPrice,
        insurancePrice,
        startDate,
        endDate,
        isFav,
    orderNumber,
      ];
}
