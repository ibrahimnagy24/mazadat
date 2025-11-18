import 'package:equatable/equatable.dart';
import '../../../../core/utils/enums/enums.dart';

class MyAuctionEntity extends Equatable {
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

  const MyAuctionEntity({
    required this.auctionType,
    required this.auctionStatus,
    required this.primaryPhoto,
    required this.name,
    required this.description,
    required this.openingPrice,
    required this.insurancePrice,
    required this.startDate,
    required this.endDate,
    required this.id,
    required this.searchId,
    required this.isFav,
    required this.orderNumber,
  });

  @override
  List<Object?> get props => [
        auctionType,
        auctionStatus,
        primaryPhoto,
        name,
        description,
        openingPrice,
        insurancePrice,
        startDate,
        endDate,
        id,
        searchId,
        isFav,
        orderNumber,
      ];
}
