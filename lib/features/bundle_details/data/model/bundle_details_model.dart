import '../../../../core/utils/constant/app_constant.dart';
import '../../../auctions/data/model/auction_model.dart';

class BundleDetailsModel {
  int? id;
  String? name;
  String? price;
  String? numberOfAuctions;
  List<AuctionModel>? auction;
  bool? isJoined;
  BundleDetailsModel({
    this.id,
    this.name,
    this.numberOfAuctions,
    this.price,
    this.auction,
    this.isJoined,
  });

  BundleDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    numberOfAuctions =
        json['numberOfAuctions']?.toString() ?? AppConstant.nullFromBack;
    price = json['price']?.toString() ?? AppConstant.nullFromBack;
    if (json['DATA']['auctions'] != null) {
      auction = <AuctionModel>[];
      json['DATA']['auctions'].forEach((v) {
        auction!.add(AuctionModel.fromJson(v));
      });
    }
    isJoined = json['DATA']['isJoined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['numberOfAuctions'] = numberOfAuctions;
    data['price'] = price;
    data['isJoined'] = isJoined;
    return data;
  }
}
