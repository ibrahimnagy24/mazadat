import '../entity/checkout_summary_entity.dart';

class CheckoutSummaryModel extends CheckoutSummaryEntity {
  const CheckoutSummaryModel({
    required super.message,
    required super.code,
    required super.status,
    required super.data,
  });

  factory CheckoutSummaryModel.fromJson(Map<String, dynamic> json) =>
      CheckoutSummaryModel(
        message: json['MESSAGE'],
        code: json['CODE'],
        status: json['STATUS'],
        data: CheckoutDataModel.fromJson(json['DATA']),
      );
}

class CheckoutDataModel extends CheckoutData {
  const CheckoutDataModel({
    required super.auctionNumber,
    required super.product,
    required super.deliveryPrice,
    required super.vatAmount,
    required super.totalAmountNoVat,
    required super.totalAmount,
    required super.insurancePrice,
    required super.appCommissionPercentage,
    required super.vatPercentage,
    required super.appCommissionAmount,
    required super.paymentDeadline,
    required super.id,
    required super.productPrice,
  });

  factory CheckoutDataModel.fromJson(Map<String, dynamic> json) =>
      CheckoutDataModel(
        auctionNumber: json['auctionNumber'],
        product: CheckoutAuctionProductModel.fromJson(json['product']),
        deliveryPrice: json['deliveryPrice'],
        vatAmount: json['vatAmount'],
        totalAmountNoVat: json['totalAmountNoVat'],
        totalAmount: json['totalAmount'],
        insurancePrice: json['insurancePrice'],
        appCommissionPercentage: json['appCommissionPercentage'],
        vatPercentage: json['vatPercentage'],
        appCommissionAmount: json['appCommissionAmount'],
        paymentDeadline: DateTime.parse(json['paymentDeadline']),
        id: json['id'],
        productPrice: json['productPrice'],
      );
}

class CheckoutAuctionProductModel extends CheckoutAuctionProductEntity {
  const CheckoutAuctionProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.sellerId,
    required super.videoId,
    required super.video,
    required super.seller,
    required super.productCategory,
    required super.productCategoryId,
    required super.status,
    required super.createdBy,
    required super.creationDate,
    required super.lastUpdatedBy,
    required super.lastUpdateDate,
    required super.images,
    required super.imagesList,
  });

  factory CheckoutAuctionProductModel.fromJson(Map<String, dynamic> json) =>
      CheckoutAuctionProductModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        sellerId: json['sellerId'],
        videoId: json['videoId'],
        video: json['video'],
        seller: CheckoutSellerModel.fromJson(json['seller']),
        productCategory:
            CheckoutProductCategoryModel.fromJson(json['productCategory']),
        productCategoryId: json['productCategoryId'],
        status: json['status'],
        createdBy: json['createdBy'],
        creationDate: DateTime.parse(json['creationDate']),
        lastUpdatedBy: json['lastUpdatedBy'],
        lastUpdateDate: DateTime.parse(json['lastUpdateDate']),
        images: List<CheckoutAuctionImageModel>.from(
            json['images'].map((x) => CheckoutAuctionImageModel.fromJson(x))),
        imagesList: json['imagesList'],
      );
}

class CheckoutAuctionImageModel extends CheckoutAuctionImageEntity {
  const CheckoutAuctionImageModel({
    required super.id,
    required super.name,
    required super.displayName,
    required super.type,
    required super.path,
    required super.categoryId,
    required super.categoryType,
  });

  factory CheckoutAuctionImageModel.fromJson(Map<String, dynamic> json) =>
      CheckoutAuctionImageModel(
        id: json['id'],
        name: json['name'],
        displayName: json['displayName'],
        type: json['type'],
        path: json['path'],
        categoryId: json['categoryId'],
        categoryType: json['categoryType'],
      );
}

class CheckoutProductCategoryModel extends CheckoutProductCategoryEntity {
  const CheckoutProductCategoryModel({
    required super.id,
    required super.nameEn,
    required super.nameAr,
    required super.descriptionEn,
    required super.descriptionAr,
    required super.iconId,
    required super.icon,
    required super.sequence,
    required super.status,
    required super.createdBy,
    required super.creationDate,
    required super.lastUpdatedBy,
    required super.lastUpdateDate,
    required super.name,
    required super.description,
  });

  factory CheckoutProductCategoryModel.fromJson(Map<String, dynamic> json) =>
      CheckoutProductCategoryModel(
        id: json['id'],
        nameEn: json['nameEn'],
        nameAr: json['nameAr'],
        descriptionEn: json['descriptionEn'],
        descriptionAr: json['descriptionAr'],
        iconId: json['iconId'],
        icon: CheckoutAuctionImageModel.fromJson(json['icon']),
        sequence: json['sequence'],
        status: json['status'],
        createdBy: json['createdBy'],
        creationDate: DateTime.parse(json['creationDate']),
        lastUpdatedBy: json['lastUpdatedBy'],
        lastUpdateDate: DateTime.parse(json['lastUpdateDate']),
        name: json['name'],
        description: json['description'],
      );
}

class CheckoutSellerModel extends CheckoutSellerEntity {
  const CheckoutSellerModel({
    required super.fullName,
    required super.id,
  });

  factory CheckoutSellerModel.fromJson(Map<String, dynamic> json) =>
      CheckoutSellerModel(
        fullName: json['fullName'],
        id: json['id'],
      );
}
