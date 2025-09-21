import 'package:equatable/equatable.dart';

class AuctionEntity extends Equatable {
  final int id;
  final String? searchId;
  final String? favoriteId;
  final String status;
  final String statusLabel;
  final AuctionTypeEntity auctionType;
  final AuctionCategoryEntity auctionCategory;
  final List<AuctionImageEntity> images;
  final String openingPrice;
  final String paymentStatus;
  final String startDate;
  final String endDate;
  final bool isWinner;
  final String? paymentDeadline;
  final Map<String, dynamic> shipment;
  final bool myfav;
  final String name;
  final String description;
  final int productId;
  final String primaryPhoto;

  const AuctionEntity({
    required this.id,
    required this.searchId,
    required this.favoriteId,
    required this.status,
    required this.statusLabel,
    required this.auctionType,
    required this.auctionCategory,
    required this.images,
    required this.openingPrice,
    required this.paymentStatus,
    required this.startDate,
    required this.endDate,
    required this.isWinner,
    required this.paymentDeadline,
    required this.shipment,
    required this.myfav,
    required this.name,
    required this.description,
    required this.productId,
    required this.primaryPhoto,
  });

  @override
  List<Object?> get props => [
        id,
        searchId,
        favoriteId,
        status,
        statusLabel,
        auctionType,
        auctionCategory,
        images,
        openingPrice,
        paymentStatus,
        startDate,
        endDate,
        isWinner,
        paymentDeadline,
        shipment,
        myfav,
        name,
        description,
        productId,
        primaryPhoto,
      ];
}

class AuctionTypeEntity extends Equatable {
  final String code;
  final String name;
  final int id;

  const AuctionTypeEntity({
    required this.code,
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [code, name, id];
}

class AuctionCategoryEntity extends Equatable {
  final String name;
  final String icon;
  final String description;
  final int id;

  const AuctionCategoryEntity({
    required this.name,
    required this.icon,
    required this.description,
    required this.id,
  });

  @override
  List<Object?> get props => [name, icon, description, id];
}

class AuctionImageEntity extends Equatable {
  final int id;
  final String name;
  final String displayName;
  final String? type;
  final String path;
  final int categoryId;

  const AuctionImageEntity({
    required this.id,
    required this.name,
    required this.displayName,
    required this.type,
    required this.path,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [id, name, displayName, type, path, categoryId];
}

class AuctionsResponseEntity extends Equatable {
  final List<AuctionEntity> content;

  const AuctionsResponseEntity({
    required this.content,
  });

  @override
  List<Object?> get props => [content];
}
