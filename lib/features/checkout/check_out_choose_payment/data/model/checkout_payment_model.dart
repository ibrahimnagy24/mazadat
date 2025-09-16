import '../../../../../core/utils/utility.dart';
import '../entity/checkout_payment_entity.dart';

class CheckoutPaymentModel extends CheckoutPaymentEntity {
  const CheckoutPaymentModel({
    required super.methods,
    required super.walletBalance,
  });

  factory CheckoutPaymentModel.fromJson(Map<String, dynamic> json) =>
      CheckoutPaymentModel(
        methods: checkFromArray(json['METHODS'])
            ? (json['METHODS'] as List)
                .map((e) => CheckoutPaymentMethodModel.fromJson(e))
                .toList()
            : [],
        walletBalance: json['WALLET_BALANCE'] ?? '0.00',
      );
}

class CheckoutPaymentMethodModel extends CheckoutPaymentMethodEntity {
  const CheckoutPaymentMethodModel({
    required super.id,
    required super.nameEn,
    required super.nameAr,
    super.icon,
    super.entityId,
    required super.type,
    required super.name,
  });

  factory CheckoutPaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      CheckoutPaymentMethodModel(
        id: json['id'],
        nameEn: json['nameEn'] ?? '',
        nameAr: json['nameAr'] ?? '',
        icon: json['icon'],
        entityId: json['entityId'],
        type: json['type'] ?? '',
        name: json['name'] ?? '',
      );
}
