import '../entities/whatsapp_config_entity.dart';

class WhatsappConfigModel extends WhatsappConfigEntity {
  const WhatsappConfigModel({
    required super.whatsappNumber,
  });

  factory WhatsappConfigModel.fromJson(Map<String, dynamic> json) =>
      WhatsappConfigModel(
        whatsappNumber: json['WHATSAPP_NUMBER'] ?? '',
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['WHATSAPP_NUMBER'] = whatsappNumber;
    return data;
  }
}
