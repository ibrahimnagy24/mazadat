import '../../../../core/utils/constant/app_constant.dart';
import '../../../../core/utils/utility.dart';
import '../entity/auction_entity.dart';
import '../enums/auction_enum_converter.dart';
import '../enums/auction_enums.dart';

class AuctionModel extends AuctionEntity {
  const AuctionModel({
    required super.id,
    required super.isFav,
    required super.auctionStatus,
    required super.auctionType,
    required super.image,
    required super.productName,
    required super.productDescription,
    required super.openingPrice,
    required super.insurancePrice,
    required super.startDate,
    required super.endDate,
    required super.auctionDuration,
  });

  factory AuctionModel.fromJson(Map<String, dynamic> json) => AuctionModel(
        auctionType: checkFromMap(json['auctionType'])
            ? AuctionEnumConverter.stringToAuctionType(
                json['auctionType']['code'] ?? 'PRIVATE')
            : AuctionType.public,
        auctionStatus: json['statusLabel'],
        image:
            checkFromMap(json['attachment']) ? json['attachment']['path'] : '',
        productName: checkFromMap(json['product'])
            ? json['product']['name']
            : AppConstant.nullFromBack,
        productDescription: checkFromMap(json['product'])
            ? json['product']['description']
            : AppConstant.nullFromBack,
        openingPrice: json['openingPrice'],
        insurancePrice: json['insurancePrice'],
        startDate: json['endDate'] != null
            ? DateTime.parse(json['startDate'])
            : DateTime.now(),
        endDate: json['endDate'] != null
            ? DateTime.parse(json['endDate'])
            : DateTime.now(),
        auctionDuration: json['acutionDuration'] ?? AppConstant.nullFromBack,
        id: json['id'],
        isFav: json['myfav'],
      );
}
