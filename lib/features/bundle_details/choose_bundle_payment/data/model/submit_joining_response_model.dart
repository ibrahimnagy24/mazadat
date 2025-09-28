import '../entity/submit_joining_response_entity.dart';

class SubmitJoiningResponseModel extends SubmitJoiningResponseEntity {
  const SubmitJoiningResponseModel({
    required super.formLink,
    required super.message,
    required super.code,
    required super.status,
    required super.transactionId,
  });

  factory SubmitJoiningResponseModel.fromJson(Map<String, dynamic> json) {
    return SubmitJoiningResponseModel(
      formLink: json['FORM_LINK'],
      message: json['MESSAGE'],
      code: json['CODE'],
      status: json['STATUS'],
      transactionId: json['TRANSACTION_ID'],
    );
  }
}
