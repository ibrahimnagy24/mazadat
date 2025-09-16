import '../entity/confirm_checkout_entity.dart';

class ConfirmCheckoutModel extends ConfirmCheckoutEntity {
  const ConfirmCheckoutModel({
    required super.formLink,
    required super.payment,
    required super.message,
    required super.code,
    required super.status,
    required super.transactionId,
  });

  factory ConfirmCheckoutModel.fromJson(Map<String, dynamic> json) =>
      ConfirmCheckoutModel(
        formLink: json['FORM_LINK'] ?? '',
        payment: json['PAYMENT'] ?? '',
        message: json['MESSAGE'] ?? '',
        code: json['CODE'] ?? '',
        status: json['STATUS'] ?? '',
        transactionId: json['TRANSACTION_ID'] ?? '',
      );
}
