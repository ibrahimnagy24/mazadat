import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/enums/enums_converter.dart';

class AuctionPusherModel {
  int? id;
  String?  lastBidderId;
  double? currentBiddingAmount,maxBiddingAmount;
  bool? isJoined,firstBid, autoBiddingEnabled;
  BiddingMethod? currentBiddingMethod;



  AuctionPusherModel({
    this.id,
    this.maxBiddingAmount,
    this.lastBidderId,
    this.currentBiddingAmount,
    this.isJoined,
    this.firstBid,
    this.autoBiddingEnabled,
    this.currentBiddingMethod,
  });

  AuctionPusherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currentBiddingAmount = double.parse( json['currentBiddingAmount']?.toString()??'0');
    maxBiddingAmount = double.parse( json['maxBiddingAmount']?.toString()??'0');
    lastBidderId = json['lastBidderId'];
    isJoined = json['isJoined'];
    firstBid = json['firstBid'];
    autoBiddingEnabled = json['autoBiddingEnabled'];
    currentBiddingMethod = json['currentBiddingMethod'] != null ? BiddingMethodConverter.stringToBiddingMethod(json['currentBiddingMethod']?.toString().toUpperCase()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['currentBiddingAmount'] = currentBiddingAmount;
    data['maxBiddingAmount'] = maxBiddingAmount;
    data['lastBidderId'] = lastBidderId;
    data['isJoined'] = isJoined;
    data['firstBid'] = firstBid;
    data['autoBiddingEnabled'] = autoBiddingEnabled;
    if (currentBiddingMethod != null) {
      data['currentBiddingMethod'] = currentBiddingMethod?.name.toUpperCase();
    }
    return data;
  }
}
