class GetBundlePaymentMethodsParams {
  final int? bundleId;
  final String? checkoutId;

  const GetBundlePaymentMethodsParams({
    this.bundleId,
    this.checkoutId,
  });

  Map<String, dynamic> toJson() {
    return {
      if (bundleId != null) 'bundleId': bundleId,
      if (checkoutId != null) 'checkoutId': checkoutId,
    };
  }
}

class SelectBundlePaymentMethodParams {
  final int paymentMethodId;
  final int bundleId;
  final String? checkoutId;

  const SelectBundlePaymentMethodParams({
    required this.paymentMethodId,
    required this.bundleId,
    this.checkoutId,
  });

  Map<String, dynamic> toJson() {
    return {
      'paymentMethodId': paymentMethodId,
      'bundleId': bundleId,
      if (checkoutId != null) 'checkoutId': checkoutId,
    };
  }
}
