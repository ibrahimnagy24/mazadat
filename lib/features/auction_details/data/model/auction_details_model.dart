import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/enums/enums_converter.dart';
import '../../../auctions/data/enums/auction_enum_converter.dart';
import '../../../auctions/data/enums/auction_enums.dart';
import '../../../category/data/model/category_model.dart';

class AuctionDetailsModel {
  int? id;
  String? status;
  String? statusLabel;
  AuctionType? auctionType;
  CategoryModel? auctionCategory;
  List<AttachmentModel>? attachments;
  String? openingPrice;
  double? biddingIncrementAmount;
  double? currentBiddingAmount;
  DateTime? startDate;
  DateTime? endDate;
  String? auctionDuration;
  String? auctionNumber;
  bool? participant;
  String? videoLink;
  String? name;
  String? description;
  bool? myfav;
  bool? isStarted, isJoined, firstBid, autoBiddingEnabled;
  int? productId;
  String? primaryPhoto;
  String? maxBiddingAmount, lastBidderId;
  BiddingMethod? currentBiddingMethod;

  AuctionDetailsModel({
    this.id,
    this.status,
    this.statusLabel,
    this.auctionType,
    this.auctionCategory,
    this.attachments,
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
    this.firstBid,
    this.autoBiddingEnabled,
    this.isJoined,
    this.isStarted,
    this.maxBiddingAmount,
    this.lastBidderId,
    this.currentBiddingMethod,
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
    videoLink = json['videoLink'];
    if (json['images'] != null) {
      // images = [];
      // json['images'].forEach((v) {
      //   if (v['url'] != null) {
      //     images!.add(v['url']);
      //   }
      // });
      attachments = List.generate(
          10,
          (index) => AttachmentModel(
              url: 'https://picsum.photos/800/800?random=$index',
              isVideo: false));
      if (videoLink != null) {
        attachments?.add(AttachmentModel(url: videoLink, isVideo: true));
      }
    }
    openingPrice = json['openingPrice'];
    biddingIncrementAmount =
        double.parse(json['biddingIncrementAmount']?.toString() ?? '0');
    currentBiddingAmount =
        double.parse(json['currentBiddingAmount']?.toString() ?? '0');
    startDate = json['endDate'] != null
        ? DateTime.parse(json['startDate'])
        : DateTime.now();
    endDate = json['endDate'] != null
        ? DateTime.parse(json['endDate'])
        : DateTime.now();
    auctionDuration = json['auctionDuration'];
    auctionNumber = json['auctionNumber'];
    participant = json['participant'];
    name = json['name'];
    description = json['description'];
    myfav = json['myfav'];
    productId = json['productId'];
    primaryPhoto = json['primaryPhoto'];
    isJoined = json['participant'];
    firstBid = json['firstBid'];
    autoBiddingEnabled = json['autoBiddingEnabled'];
    maxBiddingAmount = json['maxBiddingAmount'];
    lastBidderId = json['lastBidderId'];
    isStarted = startDate?.isBefore(DateTime.now());
    currentBiddingMethod = json['currentBiddingMethod'] != null
        ? BiddingMethodConverter.stringToBiddingMethod(
            json['currentBiddingMethod']?.toString().toUpperCase())
        : null;
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
    if (attachments != null) {
      data['images'] = attachments;
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
    data['participant'] = isJoined;
    data['isStarted'] = isStarted;
    data['firstBid'] = firstBid;
    data['autoBiddingEnabled'] = autoBiddingEnabled;
    data['maxBiddingAmount'] = maxBiddingAmount;
    data['lastBidderId'] = lastBidderId;
    if (currentBiddingMethod != null) {
      data['currentBiddingMethod'] = currentBiddingMethod?.name.toUpperCase();
    }
    return data;
  }
}

class AttachmentModel {
  String? url;
  bool isVideo;
  AttachmentModel({this.url, this.isVideo = false});
}
