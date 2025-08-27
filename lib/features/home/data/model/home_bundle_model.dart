import '../../../../core/utils/constant/app_constant.dart';
import '../entity/home_bundle_entity.dart';

class HomeBundleModel extends HomeBundleEntity {
  const HomeBundleModel({
    required super.id,
    required super.name,
    required super.numberOfAuctions,
    required super.price,
  });

  factory HomeBundleModel.fromJson(Map<String, dynamic> json) =>
      HomeBundleModel(
        id: json['id'],
        name: json['name'],
        numberOfAuctions:
            json['numberOfAuctions']?.toString() ?? AppConstant.nullFromBack,
        price: json['price'] ?? AppConstant.nullFromBack,
      );
}
