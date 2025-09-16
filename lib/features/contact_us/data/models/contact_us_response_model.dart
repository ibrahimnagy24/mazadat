import '../entities/contact_us_response_entity.dart';

class ContactUsResponseModel extends ContactUsResponseEntity {
  const ContactUsResponseModel({
    required super.message,
    required super.code,
    required super.status,
  });

  factory ContactUsResponseModel.fromJson(Map<String, dynamic> json) =>
      ContactUsResponseModel(
        message: json['MESSAGE'],
        code: json['CODE'],
        status: json['STATUS'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MESSAGE'] = message;
    data['CODE'] = code;
    data['STATUS'] = status;
    return data;
  }
}
