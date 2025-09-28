import '../../../../../core/utils/utility.dart';
import '../entity/bundle_payment_entity.dart';

class BundlePaymentModel extends BundlePaymentEntity {
  const BundlePaymentModel({
    required super.methods,
    required super.walletBalance,
  });

  factory BundlePaymentModel.fromJson(Map<String, dynamic> json) =>
      BundlePaymentModel(
        methods: checkFromArray(json['METHODS'])
            ? (json['METHODS'] as List)
                .map((e) => BundlePaymentMethodModel.fromJson(e))
                .toList()
            : [],
        walletBalance: json['WALLET_BALANCE'] ?? '0.00',
      );
}

class BundlePaymentMethodModel extends BundlePaymentMethodEntity {
  const BundlePaymentMethodModel({
    required super.id,
    required super.nameEn,
    required super.nameAr,
    super.icon,
    super.entityId,
    required super.type,
    required super.name,
  });

  factory BundlePaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      BundlePaymentMethodModel(
        id: json['id'],
        nameEn: json['nameEn'] ?? '',
        nameAr: json['nameAr'] ?? '',
        icon: json['icon'],
        entityId: json['entityId'],
        type: json['type'] ?? '',
        name: json['name'] ?? '',
      );
}
