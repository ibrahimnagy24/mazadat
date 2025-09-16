import 'package:equatable/equatable.dart';

class CheckoutPaymentEntity extends Equatable {
  final List<CheckoutPaymentMethodEntity> methods;
  final String walletBalance;

  const CheckoutPaymentEntity({
    required this.methods,
    required this.walletBalance,
  });

  @override
  List<Object?> get props => [
        methods,
        walletBalance,
      ];
}

class CheckoutPaymentMethodEntity extends Equatable {
  final int id;
  final String nameEn;
  final String nameAr;
  final String? icon;
  final int? entityId;
  final String type;
  final String name;

  const CheckoutPaymentMethodEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    this.icon,
    this.entityId,
    required this.type,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameAr,
        icon,
        entityId,
        type,
        name,
      ];
}
