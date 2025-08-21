class AuctionPusherModel {
  String? userId;
  double? currentBiddingAmount;

  AuctionPusherModel({
    this.userId,
    this.currentBiddingAmount,
  });

  AuctionPusherModel.fromJson(Map<String, dynamic> json) {
    currentBiddingAmount = double.parse(json['currentAmount']?.toString() ?? '0');
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentAmount'] = currentBiddingAmount;
    data['lastBidderId'] = userId;
    return data;
  }
}
