import '../../../auctions/data/enums/auction_enum_converter.dart';
import '../../../auctions/data/enums/auction_enums.dart';
import '../../../category/data/model/category_model.dart';

class AuctionDetailsModel {
  int? id;
  String? status;
  String? statusLabel;
  AuctionType? auctionType;
  CategoryModel? auctionCategory;
  List<String>? images;
  String? openingPrice;
  String? biddingIncrementAmount;
  String? currentBiddingAmount;
  DateTime? startDate;
  DateTime? endDate;
  String? auctionDuration;
  String? auctionNumber;
  bool? participant;
  String? videoLink;
  String? name;
  String? description;
  bool? myfav;
  bool? isJoined;
  bool? isStarted;
  int? productId;
  String? primaryPhoto;

  AuctionDetailsModel({
    this.id,
    this.status,
    this.statusLabel,
    this.auctionType,
    this.auctionCategory,
    this.images,
    this.openingPrice,
    this.biddingIncrementAmount,
    this.currentBiddingAmount,
    this.startDate,
    this.endDate,
    this.auctionDuration,
    this.auctionNumber,
    this.participant,
    this.videoLink,
    this.name,
    this.description,
    this.myfav,
    this.productId,
    this.primaryPhoto,
    this.isJoined,
    this.isStarted,
  });

  AuctionDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    statusLabel = json['statusLabel'];
    auctionType = json['auctionType'] != null
        ? AuctionEnumConverter.stringToAuctionType(
            json['auctionType']['code']?.toString().toUpperCase() ?? 'PRIVATE')
        : AuctionType.public;
    auctionCategory = json['auctionCategory'] != null
        ? CategoryModel.fromJson(json['auctionCategory'])
        : null;
    if (json['images'] != null) {
      // images = [];
      // json['images'].forEach((v) {
      //   if (v['url'] != null) {
      //     images!.add(v['url']);
      //   }
      // });
      images = List.generate(
          10, (index) => 'https://picsum.photos/800/800?random=$index');
    }
    openingPrice = json['openingPrice'];
    biddingIncrementAmount = json['biddingIncrementAmount'];
    currentBiddingAmount = json['currentBiddingAmount'];
    startDate = json['endDate'] != null
        ? DateTime.parse(json['startDate'])
        : DateTime.now();
    endDate = json['endDate'] != null
        ? DateTime.parse(json['endDate'])
        : DateTime.now();
    auctionDuration = json['auctionDuration'];
    auctionNumber = json['auctionNumber'];
    participant = json['participant'];
    videoLink = json['videoLink'];
    name = json['name'];
    description = json['description'];
    myfav = json['myfav'];
    productId = json['productId'];
    primaryPhoto = json['primaryPhoto'];
    isJoined = json['isJoined'];
    isStarted = startDate?.isBefore(DateTime.now());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['statusLabel'] = statusLabel;
    if (auctionType != null) {
      data['auctionType'] = auctionType?.name.toUpperCase();
    }
    if (auctionCategory != null) {
      data['auctionCategory'] = auctionCategory!.toJson();
    }
    if (images != null) {
      data['images'] = images;
    }
    data['openingPrice'] = openingPrice;
    data['biddingIncrementAmount'] = biddingIncrementAmount;
    data['currentBiddingAmount'] = currentBiddingAmount;
    data['startDate'] = startDate?.toIso8601String();
    data['endDate'] = endDate?.toIso8601String();
    data['auctionDuration'] = auctionDuration;
    data['auctionNumber'] = auctionNumber;
    data['participant'] = participant;
    data['videoLink'] = videoLink;
    data['name'] = name;
    data['description'] = description;
    data['myfav'] = myfav;
    data['productId'] = productId;
    data['primaryPhoto'] = primaryPhoto;
    data['isJoined'] = isJoined;
    data['isStarted'] = isStarted;
    return data;
  }
}
