import '../../../../core/utils/constant/app_constant.dart';
import '../entity/shipment_entity.dart';

class ShipmentModel extends ShipmentEntity {
  const ShipmentModel({
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

  factory ShipmentModel.fromJson(Map<String, dynamic> json) => ShipmentModel(
        id: json['id'] ?? 0,
        userId: json['userId']?.toString() ?? AppConstant.nullFromBack,
        orderNumber: json['orderNumber'] ?? AppConstant.nullFromBack,
        shipmentAddress: json['shipmentAddress'] != null
            ? ShipmentAddressModel.fromJson(json['shipmentAddress'])
            : null,
        status: json['status'] ?? AppConstant.nullFromBack,
        paymentTransactionId: json['paymentTransactionId'],
        productPrice: json['productPrice'] ?? AppConstant.nullFromBack,
        insurancePrice: json['insurancePrice'],
        appCommissionAmount: json['appCommissionAmount'] ?? AppConstant.nullFromBack,
        vatPercentage: json['vatPercentage'] ?? AppConstant.nullFromBack,
        vatAmount: json['vatAmount'] ?? AppConstant.nullFromBack,
        totalAmountNoVat: json['totalAmountNoVat'],
        totalAmount: json['totalAmount'],
        deliveryPrice: json['deliveryPrice'],
        paymentDetails: json['paymentDetails'] ?? {},
        shipmentDate: json['shipmentDate'],
        deliveryDate: json['deliveryDate'],
        auction: json['auction'] != null
            ? AuctionModel.fromJson(json['auction'])
            : const AuctionModel(
                auctionNumber: '',
                productImages: [],
                productName: '',
                productDescription: '',
                buyer: BuyerModel(
                  completePhone: '',
                  fullName: '',
                  id: 0,
                  email: '',
                ),
              ),
        createdBy: json['createdBy'],
        creationDate: json['creationDate'] ?? AppConstant.nullFromBack,
        lastUpdatedBy: json['lastUpdatedBy'],
        lastUpdateDate: json['lastUpdateDate'] ?? AppConstant.nullFromBack,
      );
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

  factory ShipmentAddressModel.fromJson(Map<String, dynamic> json) =>
      ShipmentAddressModel(
        id: json['id'] ?? 0,
        type: json['type'] ?? AppConstant.nullFromBack,
        addressType: json['addressType'] != null
            ? AddressTypeModel.fromJson(json['addressType'])
            : const AddressTypeModel(
                id: 0,
                name: '',
                createdBy: '',
                creationDate: '',
                lastUpdatedBy: '',
                lastUpdateDate: '',
              ),
        userId: json['userId'] ?? AppConstant.nullFromBack,
        desc: json['desc'] ?? AppConstant.nullFromBack,
        street: json['street'],
        phone: json['phone'] ?? AppConstant.nullFromBack,
        regionId: json['regionId'] ?? AppConstant.nullFromBack,
        region: json['region'] != null
            ? RegionModel.fromJson(json['region'])
            : const RegionModel(
                id: 0,
                nameEn: '',
                nameAr: '',
                status: '',
                name: '',
                createdBy: '',
                creationDate: '',
                lastUpdatedBy: '',
                lastUpdateDate: '',
              ),
        cityId: json['cityId'] ?? AppConstant.nullFromBack,
        city: json['city'] != null
            ? CityModel.fromJson(json['city'])
            : const CityModel(
                id: 0,
                nameEn: '',
                nameAr: '',
                status: '',
                regionId: 0,
                name: '',
                createdBy: '',
                creationDate: '',
                lastUpdatedBy: '',
                lastUpdateDate: '',
              ),
        districtId: json['districtId'] ?? AppConstant.nullFromBack,
        district: json['district'] != null
            ? DistrictModel.fromJson(json['district'])
            : const DistrictModel(
                id: 0,
                nameEn: '',
                nameAr: '',
                status: '',
                cityId: 0,
                createdBy: '',
                lastUpdatedBy: '',
                lastUpdateDate: '',
                name: '',
              ),
        isDefault: json['isDefault'] ?? AppConstant.nullFromBack,
        isDeleted: json['isDeleted'] ?? AppConstant.nullFromBack,
        createdBy: json['createdBy'] ?? AppConstant.nullFromBack,
        creationDate: json['creationDate'] ?? AppConstant.nullFromBack,
        lastUpdatedBy: json['lastUpdatedBy'] ?? AppConstant.nullFromBack,
        lastUpdateDate: json['lastUpdateDate'] ?? AppConstant.nullFromBack,
      );
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

  factory AddressTypeModel.fromJson(Map<String, dynamic> json) =>
      AddressTypeModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? AppConstant.nullFromBack,
        createdBy: json['createdBy'] ?? AppConstant.nullFromBack,
        creationDate: json['creationDate'] ?? AppConstant.nullFromBack,
        lastUpdatedBy: json['lastUpdatedBy'] ?? AppConstant.nullFromBack,
        lastUpdateDate: json['lastUpdateDate'] ?? AppConstant.nullFromBack,
      );
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

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
        id: json['id'] ?? 0,
        nameEn: json['nameEn'] ?? AppConstant.nullFromBack,
        nameAr: json['nameAr'] ?? AppConstant.nullFromBack,
        status: json['status'] ?? AppConstant.nullFromBack,
        name: json['name'] ?? AppConstant.nullFromBack,
        createdBy: json['createdBy'] ?? AppConstant.nullFromBack,
        creationDate: json['creationDate'] ?? AppConstant.nullFromBack,
        lastUpdatedBy: json['lastUpdatedBy'] ?? AppConstant.nullFromBack,
        lastUpdateDate: json['lastUpdateDate'] ?? AppConstant.nullFromBack,
      );
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

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json['id'] ?? 0,
        nameEn: json['nameEn'] ?? AppConstant.nullFromBack,
        nameAr: json['nameAr'] ?? AppConstant.nullFromBack,
        status: json['status'] ?? AppConstant.nullFromBack,
        regionId: json['regionId'] ?? 0,
        name: json['name'] ?? AppConstant.nullFromBack,
        createdBy: json['createdBy'] ?? AppConstant.nullFromBack,
        creationDate: json['creationDate'] ?? AppConstant.nullFromBack,
        lastUpdatedBy: json['lastUpdatedBy'] ?? AppConstant.nullFromBack,
        lastUpdateDate: json['lastUpdateDate'] ?? AppConstant.nullFromBack,
      );
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

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
        id: json['id'] ?? 0,
        nameEn: json['nameEn'] ?? AppConstant.nullFromBack,
        nameAr: json['nameAr'] ?? AppConstant.nullFromBack,
        status: json['status'] ?? AppConstant.nullFromBack,
        cityId: json['cityId'] ?? 0,
        createdBy: json['createdBy'] ?? AppConstant.nullFromBack,
        lastUpdatedBy: json['lastUpdatedBy'] ?? AppConstant.nullFromBack,
        lastUpdateDate: json['lastUpdateDate'] ?? AppConstant.nullFromBack,
        name: json['name'] ?? AppConstant.nullFromBack,
      );
}

class AuctionModel extends AuctionEntity {
  const AuctionModel({
    required super.auctionNumber,
    required super.productImages,
    required super.productName,
    required super.productDescription,
    required super.buyer,
  });

  factory AuctionModel.fromJson(Map<String, dynamic> json) => AuctionModel(
        auctionNumber: json['auctionNumber'] ?? AppConstant.nullFromBack,
        productImages: json['productImages'] != null
            ? (json['productImages'] as List)
                .map((e) => ProductImageModel.fromJson(e))
                .toList()
            : [],
        productName: json['productName'] ?? AppConstant.nullFromBack,
        productDescription: json['productDescription'] ?? AppConstant.nullFromBack,
        buyer: json['buyer'] != null
            ? BuyerModel.fromJson(json['buyer'])
            : const BuyerModel(
                completePhone: '',
                fullName: '',
                id: 0,
                email: '',
              ),
      );
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

  factory ProductImageModel.fromJson(Map<String, dynamic> json) =>
      ProductImageModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? AppConstant.nullFromBack,
        displayName: json['displayName'] ?? AppConstant.nullFromBack,
        type: json['type'] ?? AppConstant.nullFromBack,
        path: json['path'] ?? AppConstant.nullFromBack,
        categoryId: json['categoryId'] ?? 0,
      );
}

class BuyerModel extends BuyerEntity {
  const BuyerModel({
    required super.completePhone,
    required super.fullName,
    required super.id,
    required super.email,
  });

  factory BuyerModel.fromJson(Map<String, dynamic> json) => BuyerModel(
        completePhone: json['completePhone'] ?? AppConstant.nullFromBack,
        fullName: json['fullName'] ?? AppConstant.nullFromBack,
        id: json['id'] ?? 0,
        email: json['email'] ?? AppConstant.nullFromBack,
      );
}

class ShipmentsResponseModel extends ShipmentsResponseEntity {
  const ShipmentsResponseModel({
    required super.content,
  });

  factory ShipmentsResponseModel.fromJson(Map<String, dynamic> json) =>
      ShipmentsResponseModel(
        content: json['content'] != null
            ? (json['content'] as List)
                .map((e) => ShipmentModel.fromJson(e))
                .toList()
            : [],
      );
}
