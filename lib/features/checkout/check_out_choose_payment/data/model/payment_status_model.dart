import '../entity/payment_status_entity.dart';

class PaymentStatusModel extends PaymentStatusEntity {
  const PaymentStatusModel({
    required super.shipmentId,
    required super.message,
    required super.status,
    required super.code,
  });

  factory PaymentStatusModel.fromJson(Map<String, dynamic> json) {
    return PaymentStatusModel(
      shipmentId: json['SHIPMENT_ID'] ?? 0,
      message: json['MESSAGE'] ?? '',
      status: json['STATUS'] ?? '',
      code: json['CODE'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SHIPMENT_ID': shipmentId,
      'MESSAGE': message,
      'STATUS': status,
      'CODE': code,
    };
  }
}
