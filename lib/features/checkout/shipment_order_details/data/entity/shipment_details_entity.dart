import 'package:equatable/equatable.dart';

class ShipmentDetailsEntity extends Equatable {
  final String message;
  final String code;
  final String status;
  final ShipmentDataEntity data;

  const ShipmentDetailsEntity({
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

class ShipmentDataEntity extends Equatable {
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
  final ShipmentAuctionEntity auction;
  final String createdBy;
  final String creationDate;
  final String lastUpdatedBy;
  final String lastUpdateDate;

  const ShipmentDataEntity({
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

class ShipmentAuctionEntity extends Equatable {
  final String auctionNumber;
  final String deliveryPrice;
  final String productName;
  final BuyerEntity buyer;
  final String image;

  const ShipmentAuctionEntity({
    required this.auctionNumber,
    required this.deliveryPrice,
    required this.productName,
    required this.buyer,
    required this.image,
  });

  @override
  List<Object?> get props => [
        auctionNumber,
        deliveryPrice,
        productName,
        buyer,
        image,
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
