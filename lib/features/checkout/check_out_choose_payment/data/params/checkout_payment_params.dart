class GetCheckoutPaymentMethodsParams {
  final int? auctionId;
  final String? checkoutId;

  const GetCheckoutPaymentMethodsParams({
    this.auctionId,
    this.checkoutId,
  });

  Map<String, dynamic> toJson() {
    return {
      if (auctionId != null) 'auctionId': auctionId,
      if (checkoutId != null) 'checkoutId': checkoutId,
    };
  }
}

class SelectPaymentMethodParams {
  final int paymentMethodId;
  final int auctionId;
  final String? checkoutId;

  const SelectPaymentMethodParams({
    required this.paymentMethodId,
    required this.auctionId,
    this.checkoutId,
  });

  Map<String, dynamic> toJson() {
    return {
      'paymentMethodId': paymentMethodId,
      'auctionId': auctionId,
      if (checkoutId != null) 'checkoutId': checkoutId,
    };
  }
}
