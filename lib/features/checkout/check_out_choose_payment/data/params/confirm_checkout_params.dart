class ConfirmCheckoutParams {
  final int auctionId;
  final int paymentType;

  const ConfirmCheckoutParams({
    required this.auctionId,
    required this.paymentType,
  });

  Map<String, dynamic> toJson() {
    return {
      'auctionId': auctionId,
      'paymentType': paymentType,
    };
  }
}
