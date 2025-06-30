import '../../../../core/utils/constant/app_constant.dart';
import '../../../../core/utils/utility.dart';
import '../entity/auction_entity.dart';

class AuctionModel extends AuctionEntity {
  const AuctionModel({
    required super.auctionTypeName,
    required super.image,
    required super.productName,
    required super.productDescription,
    required super.openingPrice,
    required super.insurancePrice,
    required super.endDate,
    required super.auctionDuration,
    required super.id,
  });

  factory AuctionModel.fromJson(Map<String, dynamic> json) => AuctionModel(
        auctionTypeName: checkFromMap(json['auctionType'])
            ? json['auctionType']['name']
            : AppConstant.nullFromBack,
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
        endDate: json['endDate'],
        auctionDuration: json['acutionDuration'] ?? AppConstant.nullFromBack,
        id: json['id'],
      );
}
