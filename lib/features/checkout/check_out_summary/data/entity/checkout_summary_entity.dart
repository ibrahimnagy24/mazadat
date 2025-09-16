import 'package:equatable/equatable.dart';

import '../../../../address/address_types/data/model/address_type_model.dart';

class CheckoutSummaryEntity extends Equatable {
  final String message;
  final String code;
  final String status;
  final CheckoutData data;

  const CheckoutSummaryEntity({
    required this.message,
    required this.code,
    required this.status,
    required this.data,
  });

  @override
  List<Object?> get props => [
        message,
        code,
        status,
        data,
      ];
}

class CheckoutData extends Equatable {
  final String auctionNumber;
  final CheckoutAuctionProductEntity product;
  final int deliveryPrice;
  final int vatAmount;
  final int totalAmountNoVat;
  final int totalAmount;
  final int insurancePrice;
  final String appCommissionPercentage;
  final int vatPercentage;
  final int appCommissionAmount;
  final DateTime paymentDeadline;
  final int id;
  final int productPrice;
  final CheckoutShipmentAddressEntity shipmentAddress;

  const CheckoutData({
    required this.auctionNumber,
    required this.product,
    required this.deliveryPrice,
    required this.vatAmount,
    required this.totalAmountNoVat,
    required this.totalAmount,
    required this.insurancePrice,
    required this.appCommissionPercentage,
    required this.vatPercentage,
    required this.appCommissionAmount,
    required this.paymentDeadline,
    required this.id,
    required this.productPrice,
    required this.shipmentAddress,
  });

  @override
  List<Object?> get props => [
        auctionNumber,
        product,
        deliveryPrice,
        vatAmount,
        totalAmountNoVat,
        totalAmount,
        insurancePrice,
        appCommissionPercentage,
        vatPercentage,
        appCommissionAmount,
        paymentDeadline,
        id,
        productPrice,
        shipmentAddress,
      ];
}

class CheckoutAuctionProductEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String sellerId;
  final dynamic videoId;
  final dynamic video;
  final CheckoutSellerEntity seller;
  final CheckoutProductCategoryEntity productCategory;
  final String productCategoryId;
  final String status;
  final String createdBy;
  final DateTime creationDate;
  final String lastUpdatedBy;
  final DateTime lastUpdateDate;
  final List<CheckoutAuctionImageEntity> images;
  final dynamic imagesList;

  const CheckoutAuctionProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.sellerId,
    required this.videoId,
    required this.video,
    required this.seller,
    required this.productCategory,
    required this.productCategoryId,
    required this.status,
    required this.createdBy,
    required this.creationDate,
    required this.lastUpdatedBy,
    required this.lastUpdateDate,
    required this.images,
    required this.imagesList,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        sellerId,
        videoId,
        video,
        seller,
        productCategory,
        productCategoryId,
        status,
        createdBy,
        creationDate,
        lastUpdatedBy,
        lastUpdateDate,
        images,
        imagesList,
      ];
}

class CheckoutAuctionImageEntity extends Equatable {
  final int id;
  final String name;
  final String displayName;
  final String? type;
  final String path;
  final int? categoryId;
  final dynamic categoryType;

  const CheckoutAuctionImageEntity({
    required this.id,
    required this.name,
    required this.displayName,
    required this.type,
    required this.path,
    required this.categoryId,
    required this.categoryType,
  });

  @override
  List<Object?> get props =>
      [id, name, displayName, type, path, categoryId, categoryType];
}

class CheckoutProductCategoryEntity extends Equatable {
  final int id;
  final String nameEn;
  final String nameAr;
  final dynamic descriptionEn;
  final String descriptionAr;
  final String iconId;
  final CheckoutAuctionImageEntity icon;
  final String sequence;
  final String status;
  final String createdBy;
  final DateTime creationDate;
  final String lastUpdatedBy;
  final DateTime lastUpdateDate;
  final String name;
  final String description;

  const CheckoutProductCategoryEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.iconId,
    required this.icon,
    required this.sequence,
    required this.status,
    required this.createdBy,
    required this.creationDate,
    required this.lastUpdatedBy,
    required this.lastUpdateDate,
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameAr,
        descriptionEn,
        descriptionAr,
        iconId,
        icon,
        sequence,
        status,
        createdBy,
        creationDate,
        lastUpdatedBy,
        lastUpdateDate,
        name,
        description,
      ];
}

class CheckoutSellerEntity extends Equatable {
  final String fullName;
  final int id;

  const CheckoutSellerEntity({
    required this.fullName,
    required this.id,
  });

  @override
  List<Object?> get props => [fullName, id];
}

class CheckoutShipmentAddressEntity extends Equatable {
  final int id;
  final AddressTypeModel addressType;
  final dynamic userId;
  final String description;

  const CheckoutShipmentAddressEntity({
    required this.id,
    required this.addressType,
    required this.userId,
    required this.description,
  });

  @override
  List<Object?> get props => [id, addressType, userId, description];
}
