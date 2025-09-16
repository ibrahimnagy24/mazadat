import '../entity/my_purchase_content_entity.dart';

class MyPurchaseContentModel extends MyPurchaseContentEntity {
  const MyPurchaseContentModel({
    required super.id,
    required super.userId,
    required super.orderNumber,
    required super.shipmentAddress,
    required super.status,
    required super.paymentTransactionId,
    required super.productPrice,
    required super.insurancePrice,
    required super.appCommissionAmount,
    required super.vatPercentage,
    required super.vatAmount,
    required super.totalAmountNoVat,
    required super.totalAmount,
    required super.deliveryPrice,
    required super.paymentDetails,
    required super.shipmentDate,
    required super.deliveryDate,
    required super.auction,
    required super.createdBy,
    required super.creationDate,
    required super.lastUpdatedBy,
    required super.lastUpdateDate,
  });

  factory MyPurchaseContentModel.fromJson(Map<String, dynamic> json) {
    return MyPurchaseContentModel(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? '',
      orderNumber: json['orderNumber'] ?? '',
      shipmentAddress: ShipmentAddressModel.fromJson(json['shipmentAddress'] ?? {}),
      status: json['status'] ?? '',
      paymentTransactionId: json['paymentTransactionId'],
      productPrice: json['productPrice'] ?? '',
      insurancePrice: json['insurancePrice'] ?? '',
      appCommissionAmount: json['appCommissionAmount'] ?? '',
      vatPercentage: json['vatPercentage'] ?? '',
      vatAmount: json['vatAmount'] ?? '',
      totalAmountNoVat: json['totalAmountNoVat'] ?? '',
      totalAmount: json['totalAmount'] ?? '',
      deliveryPrice: json['deliveryPrice'] ?? '',
      paymentDetails: json['paymentDetails'] ?? {},
      shipmentDate: json['shipmentDate'],
      deliveryDate: json['deliveryDate'],
      auction: PurchaseAuctionModel.fromJson(json['auction'] ?? {}),
      createdBy: json['createdBy'] ?? '',
      creationDate: json['creationDate'] ?? '',
      lastUpdatedBy: json['lastUpdatedBy'] ?? '',
      lastUpdateDate: json['lastUpdateDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'orderNumber': orderNumber,
      'shipmentAddress': (shipmentAddress as ShipmentAddressModel).toJson(),
      'status': status,
      'paymentTransactionId': paymentTransactionId,
      'productPrice': productPrice,
      'insurancePrice': insurancePrice,
      'appCommissionAmount': appCommissionAmount,
      'vatPercentage': vatPercentage,
      'vatAmount': vatAmount,
      'totalAmountNoVat': totalAmountNoVat,
      'totalAmount': totalAmount,
      'deliveryPrice': deliveryPrice,
      'paymentDetails': paymentDetails,
      'shipmentDate': shipmentDate,
      'deliveryDate': deliveryDate,
      'auction': (auction as PurchaseAuctionModel).toJson(),
      'createdBy': createdBy,
      'creationDate': creationDate,
      'lastUpdatedBy': lastUpdatedBy,
      'lastUpdateDate': lastUpdateDate,
    };
  }
}

class ShipmentAddressModel extends ShipmentAddressEntity {
  const ShipmentAddressModel({
    required super.id,
    required super.type,
    required super.addressType,
    required super.userId,
    required super.desc,
    required super.street,
    required super.phone,
    required super.regionId,
    required super.region,
    required super.cityId,
    required super.city,
    required super.districtId,
    required super.district,
    required super.isDefault,
    required super.isDeleted,
    required super.createdBy,
    required super.creationDate,
    required super.lastUpdatedBy,
    required super.lastUpdateDate,
  });

  factory ShipmentAddressModel.fromJson(Map<String, dynamic> json) {
    return ShipmentAddressModel(
      id: json['id'] ?? 0,
      type: json['type'] ?? '',
      addressType: AddressTypeModel.fromJson(json['addressType'] ?? {}),
      userId: json['userId'] ?? '',
      desc: json['desc'] ?? '',
      street: json['street'],
      phone: json['phone'] ?? '',
      regionId: json['regionId'] ?? '',
      region: RegionModel.fromJson(json['region'] ?? {}),
      cityId: json['cityId'] ?? '',
      city: CityModel.fromJson(json['city'] ?? {}),
      districtId: json['districtId'] ?? '',
      district: DistrictModel.fromJson(json['district'] ?? {}),
      isDefault: json['isDefault'] ?? '',
      isDeleted: json['isDeleted'] ?? '',
      createdBy: json['createdBy'] ?? '',
      creationDate: json['creationDate'] ?? '',
      lastUpdatedBy: json['lastUpdatedBy'] ?? '',
      lastUpdateDate: json['lastUpdateDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'addressType': (addressType as AddressTypeModel).toJson(),
      'userId': userId,
      'desc': desc,
      'street': street,
      'phone': phone,
      'regionId': regionId,
      'region': (region as RegionModel).toJson(),
      'cityId': cityId,
      'city': (city as CityModel).toJson(),
      'districtId': districtId,
      'district': (district as DistrictModel).toJson(),
      'isDefault': isDefault,
      'isDeleted': isDeleted,
      'createdBy': createdBy,
      'creationDate': creationDate,
      'lastUpdatedBy': lastUpdatedBy,
      'lastUpdateDate': lastUpdateDate,
    };
  }
}

class AddressTypeModel extends AddressTypeEntity {
  const AddressTypeModel({
    required super.id,
    required super.name,
    required super.createdBy,
    required super.creationDate,
    required super.lastUpdatedBy,
    required super.lastUpdateDate,
  });

  factory AddressTypeModel.fromJson(Map<String, dynamic> json) {
    return AddressTypeModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      createdBy: json['createdBy'] ?? '',
      creationDate: json['creationDate'] ?? '',
      lastUpdatedBy: json['lastUpdatedBy'] ?? '',
      lastUpdateDate: json['lastUpdateDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdBy': createdBy,
      'creationDate': creationDate,
      'lastUpdatedBy': lastUpdatedBy,
      'lastUpdateDate': lastUpdateDate,
    };
  }
}

class RegionModel extends RegionEntity {
  const RegionModel({
    required super.id,
    required super.nameEn,
    required super.nameAr,
    required super.status,
    required super.name,
    required super.createdBy,
    required super.creationDate,
    required super.lastUpdatedBy,
    required super.lastUpdateDate,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json['id'] ?? 0,
      nameEn: json['nameEn'] ?? '',
      nameAr: json['nameAr'] ?? '',
      status: json['status'] ?? '',
      name: json['name'] ?? '',
      createdBy: json['createdBy'] ?? '',
      creationDate: json['creationDate'] ?? '',
      lastUpdatedBy: json['lastUpdatedBy'] ?? '',
      lastUpdateDate: json['lastUpdateDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'status': status,
      'name': name,
      'createdBy': createdBy,
      'creationDate': creationDate,
      'lastUpdatedBy': lastUpdatedBy,
      'lastUpdateDate': lastUpdateDate,
    };
  }
}

class CityModel extends CityEntity {
  const CityModel({
    required super.id,
    required super.nameEn,
    required super.nameAr,
    required super.status,
    required super.regionId,
    required super.name,
    required super.createdBy,
    required super.creationDate,
    required super.lastUpdatedBy,
    required super.lastUpdateDate,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] ?? 0,
      nameEn: json['nameEn'] ?? '',
      nameAr: json['nameAr'] ?? '',
      status: json['status'] ?? '',
      regionId: json['regionId'] ?? 0,
      name: json['name'] ?? '',
      createdBy: json['createdBy'] ?? '',
      creationDate: json['creationDate'] ?? '',
      lastUpdatedBy: json['lastUpdatedBy'] ?? '',
      lastUpdateDate: json['lastUpdateDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'status': status,
      'regionId': regionId,
      'name': name,
      'createdBy': createdBy,
      'creationDate': creationDate,
      'lastUpdatedBy': lastUpdatedBy,
      'lastUpdateDate': lastUpdateDate,
    };
  }
}

class DistrictModel extends DistrictEntity {
  const DistrictModel({
    required super.id,
    required super.nameEn,
    required super.nameAr,
    required super.status,
    required super.cityId,
    required super.createdBy,
    required super.lastUpdatedBy,
    required super.lastUpdateDate,
    required super.name,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json['id'] ?? 0,
      nameEn: json['nameEn'] ?? '',
      nameAr: json['nameAr'] ?? '',
      status: json['status'] ?? '',
      cityId: json['cityId'] ?? 0,
      createdBy: json['createdBy'] ?? '',
      lastUpdatedBy: json['lastUpdatedBy'] ?? '',
      lastUpdateDate: json['lastUpdateDate'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'status': status,
      'cityId': cityId,
      'createdBy': createdBy,
      'lastUpdatedBy': lastUpdatedBy,
      'lastUpdateDate': lastUpdateDate,
      'name': name,
    };
  }
}

class PurchaseAuctionModel extends PurchaseAuctionEntity {
  const PurchaseAuctionModel({
    required super.auctionNumber,
    required super.productImages,
    required super.productName,
    required super.productDescription,
    required super.buyer,
  });

  factory PurchaseAuctionModel.fromJson(Map<String, dynamic> json) {
    return PurchaseAuctionModel(
      auctionNumber: json['auctionNumber'] ?? '',
      productImages: (json['productImages'] as List<dynamic>?)
              ?.map((e) => ProductImageModel.fromJson(e))
              .toList() ??
          [],
      productName: json['productName'] ?? '',
      productDescription: json['productDescription'] ?? '',
      buyer: BuyerModel.fromJson(json['buyer'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'auctionNumber': auctionNumber,
      'productImages': productImages
          .map((e) => (e as ProductImageModel).toJson())
          .toList(),
      'productName': productName,
      'productDescription': productDescription,
      'buyer': (buyer as BuyerModel).toJson(),
    };
  }
}

class ProductImageModel extends ProductImageEntity {
  const ProductImageModel({
    required super.id,
    required super.name,
    required super.displayName,
    required super.type,
    required super.path,
    required super.categoryId,
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      displayName: json['displayName'] ?? '',
      type: json['type'] ?? '',
      path: json['path'] ?? '',
      categoryId: json['categoryId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'displayName': displayName,
      'type': type,
      'path': path,
      'categoryId': categoryId,
    };
  }
}

class BuyerModel extends BuyerEntity {
  const BuyerModel({
    required super.completePhone,
    required super.fullName,
    required super.id,
    required super.email,
  });

  factory BuyerModel.fromJson(Map<String, dynamic> json) {
    return BuyerModel(
      completePhone: json['completePhone'] ?? '',
      fullName: json['fullName'] ?? '',
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'completePhone': completePhone,
      'fullName': fullName,
      'id': id,
      'email': email,
    };
  }
}
