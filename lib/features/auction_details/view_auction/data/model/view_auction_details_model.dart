import '../../../../../core/utils/enums/enums.dart';
import '../../../../../core/utils/enums/enums_converter.dart';
import '../../../../category/data/model/category_model.dart';
import '../entity/view_auction_details_entity.dart';

class ViewAuctionDetailsModel extends ViewAuctionDetailsEntity {
  const ViewAuctionDetailsModel({
    required super.id,
    required super.status,
    required super.statusLabel,
    required super.auctionType,
    required super.auctionCategory,
    required super.attachments,
    required super.openingPrice,
    required super.biddingIncrementAmount,
    required super.currentBiddingAmount,
    required super.maxBiddingAmount,
    required super.startDate,
    required super.endDate,
    required super.auctionDuration,
    required super.auctionNumber,
    required super.participant,
    required super.videoLink,
    required super.name,
    required super.description,
    required super.myfav,
    required super.isStarted,
    required super.isEnded,
    required super.isJoined,
    required super.firstBid,
    required super.autoBiddingEnabled,
    required super.productId,
    required super.primaryPhoto,
    required super.lastBidderId,
    required super.currentBiddingMethod,
  });

  factory ViewAuctionDetailsModel.fromJson(Map<String, dynamic> json) {
    final attachments = <AttachmentModel>[];

    if (json['images'] != null) {
      for (var v in json['images']) {
        if (v['path'] != null) {
          attachments.add(AttachmentModel(url: v['path'], isVideo: false));
        }
      }
    }

    final videoLink = json['videoLink']?.toString() ?? '';
    if (videoLink.isNotEmpty) {
      attachments.add(AttachmentModel(url: videoLink, isVideo: true));
    }

    return ViewAuctionDetailsModel(
      id: json['id'],
      status: json['status'],
      statusLabel: json['statusLabel'],
      auctionType: AuctionEnumConverter.stringToAuctionType(
          json['auctionType']['code']?.toString().toUpperCase() ?? 'PRIVATE'),
      auctionCategory: CategoryModel.fromJson(json['auctionCategory']),
      attachments: attachments,
      openingPrice: json['openingPrice'].toString(),
      biddingIncrementAmount:
          double.parse(json['biddingIncrementAmount'].toString()),
      currentBiddingAmount:
          double.parse(json['currentBiddingAmount'].toString()),
      maxBiddingAmount:
          json['maxBiddingAmount'] != null && json['maxBiddingAmount'] != ''
              ? double.parse(json['maxBiddingAmount'].toString().trim())
              : 0.0,
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      auctionDuration: json['auctionDuration'].toString(),
      auctionNumber: json['auctionNumber'].toString(),
      participant: json['participant'],
      videoLink: videoLink,
      name: json['name'].toString(),
      description: json['description'].toString(),
      myfav: json['myfav'],
      isStarted: json['auctionStarted'] ?? false,
      isEnded: json['auctionEnded'] ?? false,
      isJoined: json['participant'] ?? false,
      firstBid: json['firstBid'] ?? false,
      autoBiddingEnabled: json['autoBiddingEnabled'] ?? false,
      productId: json['productId'] ?? 0,
      primaryPhoto: json['primaryPhoto'].toString(),
      lastBidderId: json['lastBidderId'].toString(),
      currentBiddingMethod: json['currentBiddingMethod'] != null
          ? BiddingMethodConverter.stringToBiddingMethod(
                  json['currentBiddingMethod']?.toString().toUpperCase()) ??
              BiddingMethod.manual
          : BiddingMethod.manual,
    );
  }
}

class AttachmentModel extends AttachmentEntity {
  const AttachmentModel({
    required super.url,
    super.isVideo = false,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      url: json['url'].toString(),
      isVideo: json['isVideo'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'path': url,
      'isVideo': isVideo,
    };
  }

  AttachmentModel copyWith({
    String? url,
    bool? isVideo,
  }) {
    return AttachmentModel(
      url: url ?? this.url,
      isVideo: isVideo ?? this.isVideo,
    );
  }
}
