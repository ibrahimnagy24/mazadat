import '../../../../core/utils/constant/app_constant.dart';
import '../entity/auction_entity.dart';

class AuctionModel extends AuctionEntity {
  const AuctionModel({
    required super.id,
    required super.searchId,
    required super.favoriteId,
    required super.status,
    required super.statusLabel,
    required super.auctionType,
    required super.auctionCategory,
    required super.images,
    required super.openingPrice,
    required super.paymentStatus,
    required super.startDate,
    required super.endDate,
    required super.isWinner,
    required super.paymentDeadline,
    required super.shipment,
    required super.myfav,
    required super.name,
    required super.description,
    required super.productId,
    required super.primaryPhoto,
  });

  factory AuctionModel.fromJson(Map<String, dynamic> json) => AuctionModel(
        id: json['id'] ?? 0,
        searchId: json['searchId'],
        favoriteId: json['favoriteId'],
        status: json['status'] ?? AppConstant.nullFromBack,
        statusLabel: json['statusLabel'] ?? AppConstant.nullFromBack,
        auctionType: json['auctionType'] != null
            ? AuctionTypeModel.fromJson(json['auctionType'])
            : const AuctionTypeModel(
                code: '',
                name: '',
                id: 0,
              ),
        auctionCategory: json['auctionCategory'] != null
            ? AuctionCategoryModel.fromJson(json['auctionCategory'])
            : const AuctionCategoryModel(
                name: '',
                icon: '',
                description: '',
                id: 0,
              ),
        images: json['images'] != null
            ? (json['images'] as List)
                .map((e) => AuctionImageModel.fromJson(e))
                .toList()
            : [],
        openingPrice: json['openingPrice'] ?? AppConstant.nullFromBack,
        paymentStatus: json['paymentStatus'] ?? AppConstant.nullFromBack,
        startDate: json['startDate'] ?? AppConstant.nullFromBack,
        endDate: json['endDate'] ?? AppConstant.nullFromBack,
        isWinner: json['isWinner'] ?? false,
        paymentDeadline: json['paymentDeadline'],
        shipment: json['shipment'] ?? {},
        myfav: json['myfav'] ?? false,
        name: json['name'] ?? AppConstant.nullFromBack,
        description: json['description'] ?? AppConstant.nullFromBack,
        productId: json['productId'] ?? 0,
        primaryPhoto: json['primaryPhoto'] ?? AppConstant.nullFromBack,
      );
}

class AuctionTypeModel extends AuctionTypeEntity {
  const AuctionTypeModel({
    required super.code,
    required super.name,
    required super.id,
  });

  factory AuctionTypeModel.fromJson(Map<String, dynamic> json) =>
      AuctionTypeModel(
        code: json['code'] ?? AppConstant.nullFromBack,
        name: json['name'] ?? AppConstant.nullFromBack,
        id: json['id'] ?? 0,
      );
}

class AuctionCategoryModel extends AuctionCategoryEntity {
  const AuctionCategoryModel({
    required super.name,
    required super.icon,
    required super.description,
    required super.id,
  });

  factory AuctionCategoryModel.fromJson(Map<String, dynamic> json) =>
      AuctionCategoryModel(
        name: json['name'] ?? AppConstant.nullFromBack,
        icon: json['icon'] ?? AppConstant.nullFromBack,
        description: json['description'] ?? AppConstant.nullFromBack,
        id: json['id'] ?? 0,
      );
}

class AuctionImageModel extends AuctionImageEntity {
  const AuctionImageModel({
    required super.id,
    required super.name,
    required super.displayName,
    required super.type,
    required super.path,
    required super.categoryId,
  });

  factory AuctionImageModel.fromJson(Map<String, dynamic> json) =>
      AuctionImageModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? AppConstant.nullFromBack,
        displayName: json['displayName'] ?? AppConstant.nullFromBack,
        type: json['type'],
        path: json['path'] ?? AppConstant.nullFromBack,
        categoryId: json['categoryId'] ?? 0,
      );
}

class AuctionsResponseModel extends AuctionsResponseEntity {
  const AuctionsResponseModel({
    required super.content,
  });

  factory AuctionsResponseModel.fromJson(Map<String, dynamic> json) =>
      AuctionsResponseModel(
        content: json['content'] != null
            ? (json['content'] as List)
                .map((e) => AuctionModel.fromJson(e))
                .toList()
            : [],
      );
}
