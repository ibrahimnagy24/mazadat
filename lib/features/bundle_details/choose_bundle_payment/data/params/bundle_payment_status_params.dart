class BundlePaymentStatusParams {
  final int bundleId;
  final int paymentTransactionId;

  const BundlePaymentStatusParams({
    required this.bundleId,
    required this.paymentTransactionId,
  });

  Map<String, dynamic> toJson() {
    return {
      'bundleId': bundleId,
      'paymentTransactionId': paymentTransactionId,
    };
  }
}
