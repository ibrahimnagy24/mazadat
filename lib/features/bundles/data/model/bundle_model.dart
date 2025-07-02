import '../../../../core/utils/constant/app_constant.dart';
import '../entity/bundle_entity.dart';

class BundleModel extends BundleEntity {
  const BundleModel({
    required super.id,
    required super.name,
    required super.numberOfAuctions,
    required super.price,
  });

  factory BundleModel.fromJson(Map<String, dynamic> json) => BundleModel(
        id: json['id'],
        name: json['name'],
        numberOfAuctions:
            json['numberOfAuctions']?.toString() ?? AppConstant.nullFromBack,
        price: json['price'] ?? AppConstant.nullFromBack,
      );
}
