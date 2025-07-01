import '../../../category/data/model/category_model.dart';
import '../../../../../core/utils/utility.dart';

class AuctionDetailsModel {
  int? id;
  AuctionTypeModel? auctionType;
  ProductModel? product;
  CategoryModel? auctionCategory;
  String? attachment;
  List<String>? images;
  String? title;
  String? openingPrice;
  String? sellerCommissionAmount;
  String? buyerCommissionAmount;
  String? deliveryPrice;
  String? insuranceType;
  String? insurancePrice;
  String? insurancePrecentage;
  String? minExpectedSalary;
  String? startDate;
  String? endDate;
  String? autoBiddingEnabled;
  String? status;
  String? createdBy;
  String? creationDate;
  String? lastUpdatedBy;
  String? lastUpdateDate;
  String? isActive;
  String? isFeatured;
  int? extendCount;
  int? acutionDuration;

  AuctionDetailsModel(
      {this.id,
      this.auctionType,
      this.product,
      this.auctionCategory,
      this.attachment,
      this.images,
      this.title,
      this.openingPrice,
      this.sellerCommissionAmount,
      this.buyerCommissionAmount,
      this.deliveryPrice,
      this.insuranceType,
      this.insurancePrice,
      this.insurancePrecentage,
      this.minExpectedSalary,
      this.startDate,
      this.endDate,
      this.autoBiddingEnabled,
      this.status,
      this.createdBy,
      this.creationDate,
      this.lastUpdatedBy,
      this.lastUpdateDate,
      this.isActive,
      this.isFeatured,
      this.extendCount,
      this.acutionDuration});

  AuctionDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    auctionType = json['auctionType'] != null
        ? AuctionTypeModel.fromJson(json['auctionType'])
        : null;
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    auctionCategory = json['auctionCategory'] != null
        ? CategoryModel.fromJson(json['auctionCategory'])
        : null;
    attachment =
        checkFromMap(json['attachment']) ? json['attachment']['path'] : null;
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        if (v['url'] != null) {
          images!.add(v['url']);
        }
      });
    }
    title = json['title'];
    openingPrice = json['openingPrice'];
    sellerCommissionAmount = json['sellerCommissionAmount']?.toString();
    buyerCommissionAmount = json['buyerCommissionAmount']?.toString();
    deliveryPrice = json['deliveryPrice']?.toString();
    insuranceType = json['insuranceType'];
    insurancePrice = json['insurancePrice'];
    insurancePrecentage = json['insurancePrecentage']?.toString();
    minExpectedSalary = json['minExpectedSalary'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    autoBiddingEnabled = json['autoBiddingEnabled'];
    status = json['status'];
    createdBy = json['createdBy'];
    creationDate = json['creationDate'];
    lastUpdatedBy = json['lastUpdatedBy'];
    lastUpdateDate = json['lastUpdateDate'];
    isActive = json['isActive'];
    isFeatured = json['isFeatured'];
    extendCount = json['extendCount'];
    acutionDuration = int.parse(json['acutionDuration']?.toString() ?? '0');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (auctionType != null) {
      data['auctionType'] = auctionType!.toJson();
    }
    if (product != null) {
      data['product'] = product!.toJson();
    }

    data['images'] = images;
    data['title'] = title;
    data['openingPrice'] = openingPrice;
    data['sellerCommissionAmount'] = sellerCommissionAmount;
    data['buyerCommissionAmount'] = buyerCommissionAmount;
    data['deliveryPrice'] = deliveryPrice;
    data['insuranceType'] = insuranceType;
    data['insurancePrice'] = insurancePrice;
    data['insurancePrecentage'] = insurancePrecentage;
    data['minExpectedSalary'] = minExpectedSalary;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['autoBiddingEnabled'] = autoBiddingEnabled;
    data['status'] = status;
    data['createdBy'] = createdBy;
    data['creationDate'] = creationDate;
    data['lastUpdatedBy'] = lastUpdatedBy;
    data['lastUpdateDate'] = lastUpdateDate;
    data['isActive'] = isActive;
    data['isFeatured'] = isFeatured;
    data['extendCount'] = extendCount;
    data['acutionDuration'] = acutionDuration;

    return data;
  }
}

class AuctionTypeModel {
  int? id;
  String? code;
  String? nameEn;
  String? nameAr;
  String? status;
  int? linkedAuctionsCount;
  String? name;
  String? creationDate;
  String? lastUpdateDate;

  AuctionTypeModel(
      {this.id,
      this.code,
      this.nameEn,
      this.nameAr,
      this.status,
      this.linkedAuctionsCount,
      this.name,
      this.creationDate,
      this.lastUpdateDate});

  AuctionTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    nameEn = json['nameEn'];
    nameAr = json['nameAr'];
    status = json['status'];
    linkedAuctionsCount = json['linkedAuctionsCount'];
    name = json['name'];
    creationDate = json['creationDate'];
    lastUpdateDate = json['lastUpdateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['nameEn'] = nameEn;
    data['nameAr'] = nameAr;
    data['status'] = status;
    data['linkedAuctionsCount'] = linkedAuctionsCount;
    data['name'] = name;
    data['creationDate'] = creationDate;
    data['lastUpdateDate'] = lastUpdateDate;
    return data;
  }
}

class ProductModel {
  int? id;
  String? name;
  String? description;
  String? sellerId;
  SellerModel? seller;
  String? status;
  String? creationDate;
  String? lastUpdatedBy;
  String? lastUpdateDate;
  List<String>? images;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.sellerId,
    this.seller,
    this.status,
    this.creationDate,
    this.lastUpdatedBy,
    this.lastUpdateDate,
    this.images,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    sellerId = json['sellerId'];
    seller =
        json['seller'] != null ? SellerModel.fromJson(json['seller']) : null;
    status = json['status'];
    creationDate = json['creationDate'];
    lastUpdatedBy = json['lastUpdatedBy'];
    lastUpdateDate = json['lastUpdateDate'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        if (v['url'] != null) {
          images!.add(v['url']);
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['sellerId'] = sellerId;
    if (seller != null) {
      data['seller'] = seller!.toJson();
    }
    data['status'] = status;
    data['creationDate'] = creationDate;
    data['lastUpdatedBy'] = lastUpdatedBy;
    data['lastUpdateDate'] = lastUpdateDate;
    data['images'] = images;
    return data;
  }
}

class SellerModel {
  int? id;
  String? userType;
  String? firstName;
  String? lastName;
  String? name;
  String? countryCode;
  String? phone;
  String? email;
  String? image;

  SellerModel({
    this.id,
    this.userType,
    this.firstName,
    this.lastName,
    this.name,
    this.countryCode,
    this.phone,
    this.email,
    this.image,
  });

  SellerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['userType'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    name = json['name'];
    countryCode = json['countryCode'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userType'] = userType;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['name'] = name;
    data['countryCode'] = countryCode;
    data['phone'] = phone;
    data['email'] = email;
    data['image'] = image;

    return data;
  }
}
