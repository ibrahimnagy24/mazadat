import '../entity/bundle_payment_status_entity.dart';

class BundlePaymentStatusModel extends BundlePaymentStatusEntity {
  const BundlePaymentStatusModel({
    required super.bundleId,
    required super.message,
    required super.status,
    required super.code,
  });

  factory BundlePaymentStatusModel.fromJson(Map<String, dynamic> json) {
    return BundlePaymentStatusModel(
      bundleId: json['BUNDLE_ID'] ?? 0,
      message: json['MESSAGE'] ?? '',
      status: json['STATUS'] ?? '',
      code: json['CODE'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BUNDLE_ID': bundleId,
      'MESSAGE': message,
      'STATUS': status,
      'CODE': code,
    };
  }
}
