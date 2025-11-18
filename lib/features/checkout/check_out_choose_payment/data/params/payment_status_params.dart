class PaymentStatusParams {
  final int auctionId;
  final int paymentTransactionId;

  const PaymentStatusParams({
    required this.auctionId,
    required this.paymentTransactionId,
  });

  Map<String, dynamic> toJson() {
    return {
      'auctionId': auctionId,
      'paymentTransactionId': paymentTransactionId,
    };
  }
}
