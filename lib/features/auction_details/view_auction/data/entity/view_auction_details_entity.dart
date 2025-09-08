import 'package:equatable/equatable.dart';
import '../../../../../core/utils/enums/enums.dart';
import '../../../../category/data/model/category_model.dart';

class ViewAuctionDetailsEntity extends Equatable {
  final int id;
  final String status;
  final String statusLabel;
  final AuctionType auctionType;
  final CategoryModel auctionCategory;
  final List<AttachmentEntity> attachments;
  final String openingPrice;
  final double biddingIncrementAmount;
  final double currentBiddingAmount;
  final double maxBiddingAmount;
  final DateTime? startDate;
  final DateTime? endDate;
  final String auctionDuration;
  final String auctionNumber;
  final bool participant;
  final String videoLink;
  final String name;
  final String description;
  final bool myfav;
  final bool isStarted;
  final bool isEnded;
  final bool isJoined;
  final bool firstBid;
  final bool autoBiddingEnabled;
  final int productId;
  final String primaryPhoto;
  final String lastBidderId;
  final BiddingMethod currentBiddingMethod;

  const ViewAuctionDetailsEntity({
    required this.id,
    required this.status,
    required this.statusLabel,
    required this.auctionType,
    required this.auctionCategory,
    required this.attachments,
    required this.openingPrice,
    required this.biddingIncrementAmount,
    required this.currentBiddingAmount,
    required this.maxBiddingAmount,
    required this.startDate,
    required this.endDate,
    required this.auctionDuration,
    required this.auctionNumber,
    required this.participant,
    required this.videoLink,
    required this.name,
    required this.description,
    required this.myfav,
    required this.isStarted,
    required this.isEnded,
    required this.isJoined,
    required this.firstBid,
    required this.autoBiddingEnabled,
    required this.productId,
    required this.primaryPhoto,
    required this.lastBidderId,
    required this.currentBiddingMethod,
  });

  @override
  List<Object> get props => [
        id,
        status,
        statusLabel,
        auctionType,
        auctionCategory,
        attachments,
        openingPrice,
        biddingIncrementAmount,
        currentBiddingAmount,
        maxBiddingAmount,
        auctionDuration,
        auctionNumber,
        participant,
        videoLink,
        name,
        description,
        myfav,
        isStarted,
        isEnded,
        isJoined,
        firstBid,
        autoBiddingEnabled,
        productId,
        primaryPhoto,
        lastBidderId,
        currentBiddingMethod,
      ];
}

class AttachmentEntity extends Equatable {
  final String url;
  final bool isVideo;

  const AttachmentEntity({
    required this.url,
    this.isVideo = false,
  });

  @override
  List<Object> get props => [url, isVideo];
}
