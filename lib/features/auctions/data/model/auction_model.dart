import '../../../../core/utils/constant/app_constant.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/enums/enums_converter.dart';
import '../../../../core/utils/utility.dart';
import '../entity/auction_entity.dart';

class AuctionModel extends AuctionEntity {
  const AuctionModel({
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

  factory AuctionModel.fromJson(Map<String, dynamic> json) => AuctionModel(
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

  factory AuctionModel.fromJsonMyPurchases(Map<String, dynamic> json,
          {String? orderNumber}) =>
      AuctionModel(
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['searchId'] = searchId;
    data['image'] = auctionStatus;
    data['name'] = name;
    data['description'] = description;
    data['statusLabel'] = auctionStatus;
    data['auctionType'] = auctionType.name.toUpperCase();
    data['openingPrice'] = openingPrice;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['myfav'] = isFav;
    data['orderNumber'] = orderNumber;
    return data;
  }
}
