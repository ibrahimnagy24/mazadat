import '../../../../core/utils/constant/app_constant.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/enums/enums_converter.dart';
import '../../../../core/utils/utility.dart';
import '../entity/my_auction_entity.dart';

class MyAuctionModel extends MyAuctionEntity {
  const MyAuctionModel({
    required super.id,
    super.searchId,
    required super.isFav,
    required super.auctionStatus,
    required super.auctionType,
    required super.primaryPhoto,
    required super.name,
    required super.description,
    required super.openingPrice,
    required super.insurancePrice,
    required super.startDate,
    required super.endDate,
    super.orderNumber,
  });

  factory MyAuctionModel.fromJson(Map<String, dynamic> json) => MyAuctionModel(
        id: json['id'],
        searchId: json['searchId'],
        auctionType: checkFromMap(json['auctionType'])
            ? AuctionEnumConverter.stringToAuctionType(
                json['auctionType']['code']?.toString().toUpperCase() ??
                    'PRIVATE')
            : AuctionType.public,
        auctionStatus: json['statusLabel'] ?? AppConstant.nullFromBack,
        primaryPhoto: json['primaryPhoto'] ?? AppConstant.nullFromBack,
        name: json['name'] ?? AppConstant.nullFromBack,
        description: json['description'] ?? AppConstant.nullFromBack,
        openingPrice: json['openingPrice'],
        insurancePrice: json['insurancePrice'],
        startDate: json['endDate'] != null
            ? DateTime.parse(json['startDate'])
            : DateTime.now(),
        endDate: json['endDate'] != null
            ? DateTime.parse(json['endDate'])
            : DateTime.now(),
        isFav: json['myfav'],
        orderNumber: json['orderNumber'],
      );
}
