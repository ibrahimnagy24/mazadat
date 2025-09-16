import 'package:equatable/equatable.dart';

class MyPurchaseContentEntity extends Equatable {
  final int id;
  final String userId;
  final String orderNumber;
  final ShipmentAddressEntity shipmentAddress;
  final String status;
  final String? paymentTransactionId;
  final String productPrice;
  final String insurancePrice;
  final String appCommissionAmount;
  final String vatPercentage;
  final String vatAmount;
  final String totalAmountNoVat;
  final String totalAmount;
  final String deliveryPrice;
  final Map<String, dynamic> paymentDetails;
  final String? shipmentDate;
  final String? deliveryDate;
  final PurchaseAuctionEntity auction;
  final String createdBy;
  final String creationDate;
  final String lastUpdatedBy;
  final String lastUpdateDate;

  const MyPurchaseContentEntity({
    required this.id,
    required this.userId,
    required this.orderNumber,
    required this.shipmentAddress,
    required this.status,
    required this.paymentTransactionId,
    required this.productPrice,
    required this.insurancePrice,
    required this.appCommissionAmount,
    required this.vatPercentage,
    required this.vatAmount,
    required this.totalAmountNoVat,
    required this.totalAmount,
    required this.deliveryPrice,
    required this.paymentDetails,
    required this.shipmentDate,
    required this.deliveryDate,
    required this.auction,
    required this.createdBy,
    required this.creationDate,
    required this.lastUpdatedBy,
    required this.lastUpdateDate,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        orderNumber,
        shipmentAddress,
        status,
        paymentTransactionId,
        productPrice,
        insurancePrice,
        appCommissionAmount,
        vatPercentage,
        vatAmount,
        totalAmountNoVat,
        totalAmount,
        deliveryPrice,
        paymentDetails,
        shipmentDate,
        deliveryDate,
        auction,
        createdBy,
        creationDate,
        lastUpdatedBy,
        lastUpdateDate,
      ];
}

class ShipmentAddressEntity extends Equatable {
  final int id;
  final String type;
  final AddressTypeEntity addressType;
  final String userId;
  final String desc;
  final String? street;
  final String phone;
  final String regionId;
  final RegionEntity region;
  final String cityId;
  final CityEntity city;
  final String districtId;
  final DistrictEntity district;
  final String isDefault;
  final String isDeleted;
  final String createdBy;
  final String creationDate;
  final String lastUpdatedBy;
  final String lastUpdateDate;

  const ShipmentAddressEntity({
    required this.id,
    required this.type,
    required this.addressType,
    required this.userId,
    required this.desc,
    required this.street,
    required this.phone,
    required this.regionId,
    required this.region,
    required this.cityId,
    required this.city,
    required this.districtId,
    required this.district,
    required this.isDefault,
    required this.isDeleted,
    required this.createdBy,
    required this.creationDate,
    required this.lastUpdatedBy,
    required this.lastUpdateDate,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        addressType,
        userId,
        desc,
        street,
        phone,
        regionId,
        region,
        cityId,
        city,
        districtId,
        district,
        isDefault,
        isDeleted,
        createdBy,
        creationDate,
        lastUpdatedBy,
        lastUpdateDate,
      ];
}

class AddressTypeEntity extends Equatable {
  final int id;
  final String name;
  final String createdBy;
  final String creationDate;
  final String lastUpdatedBy;
  final String lastUpdateDate;

  const AddressTypeEntity({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.creationDate,
    required this.lastUpdatedBy,
    required this.lastUpdateDate,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        createdBy,
        creationDate,
        lastUpdatedBy,
        lastUpdateDate,
      ];
}

class RegionEntity extends Equatable {
  final int id;
  final String nameEn;
  final String nameAr;
  final String status;
  final String name;
  final String createdBy;
  final String creationDate;
  final String lastUpdatedBy;
  final String lastUpdateDate;

  const RegionEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.status,
    required this.name,
    required this.createdBy,
    required this.creationDate,
    required this.lastUpdatedBy,
    required this.lastUpdateDate,
  });

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameAr,
        status,
        name,
        createdBy,
        creationDate,
        lastUpdatedBy,
        lastUpdateDate,
      ];
}

class CityEntity extends Equatable {
  final int id;
  final String nameEn;
  final String nameAr;
  final String status;
  final int regionId;
  final String name;
  final String createdBy;
  final String creationDate;
  final String lastUpdatedBy;
  final String lastUpdateDate;

  const CityEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.status,
    required this.regionId,
    required this.name,
    required this.createdBy,
    required this.creationDate,
    required this.lastUpdatedBy,
    required this.lastUpdateDate,
  });

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameAr,
        status,
        regionId,
        name,
        createdBy,
        creationDate,
        lastUpdatedBy,
        lastUpdateDate,
      ];
}

class DistrictEntity extends Equatable {
  final int id;
  final String nameEn;
  final String nameAr;
  final String status;
  final int cityId;
  final String createdBy;
  final String lastUpdatedBy;
  final String lastUpdateDate;
  final String name;

  const DistrictEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.status,
    required this.cityId,
    required this.createdBy,
    required this.lastUpdatedBy,
    required this.lastUpdateDate,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameAr,
        status,
        cityId,
        createdBy,
        lastUpdatedBy,
        lastUpdateDate,
        name,
      ];
}

class PurchaseAuctionEntity extends Equatable {
  final String auctionNumber;
  final List<ProductImageEntity> productImages;
  final String productName;
  final String productDescription;
  final BuyerEntity buyer;

  const PurchaseAuctionEntity({
    required this.auctionNumber,
    required this.productImages,
    required this.productName,
    required this.productDescription,
    required this.buyer,
  });

  @override
  List<Object?> get props => [
        auctionNumber,
        productImages,
        productName,
        productDescription,
        buyer,
      ];
}

class ProductImageEntity extends Equatable {
  final int id;
  final String name;
  final String displayName;
  final String type;
  final String path;
  final int categoryId;

  const ProductImageEntity({
    required this.id,
    required this.name,
    required this.displayName,
    required this.type,
    required this.path,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        displayName,
        type,
        path,
        categoryId,
      ];
}

class BuyerEntity extends Equatable {
  final String completePhone;
  final String fullName;
  final int id;
  final String email;

  const BuyerEntity({
    required this.completePhone,
    required this.fullName,
    required this.id,
    required this.email,
  });

  @override
  List<Object?> get props => [
        completePhone,
        fullName,
        id,
        email,
      ];
}
