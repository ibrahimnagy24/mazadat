import '../../../../core/utils/constant/app_constant.dart';
import '../../../../core/utils/utility.dart';
import '../entity/home_auction_entity.dart';

class HomeAuctionModel extends HomeAuctionEntity {
  const HomeAuctionModel({
    required super.auctionTypeName,
    required super.image,
    required super.productName,
    required super.productDescription,
    required super.openingPrice,
    required super.insurancePrice,
    required super.endDate,
    required super.acutionDuration,
    required super.id,
  });

  factory HomeAuctionModel.fromJson(Map<String, dynamic> json) =>
      HomeAuctionModel(
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
        acutionDuration: json['acutionDuration'] ?? AppConstant.nullFromBack,
        id: json['id'],
      );
}
