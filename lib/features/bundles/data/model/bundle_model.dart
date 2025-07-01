import '../../../../core/utils/constant/app_constant.dart';
import '../../../../core/utils/utility.dart';
import '../entity/bundle_entity.dart';

class BundleModel extends BundleEntity {
  const BundleModel({
    required super.id,
    required super.name,
    required super.linkedAuctionsCount,
    required super.openingPrice,
  });

  factory BundleModel.fromJson(Map<String, dynamic> json) => BundleModel(
        id: json['id'],
        name: checkFromMap(json['name'])
            ? json['name']['path']
            : AppConstant.nullFromBack,
    linkedAuctionsCount: checkFromMap(json['linkedAuctionsCount'])
            ? json['linkedAuctionsCount']
            : AppConstant.nullFromBack,
        openingPrice: checkFromMap(json['openingPrice'])
            ? json['openingPrice']
            : AppConstant.nullFromBack,
      );
}
