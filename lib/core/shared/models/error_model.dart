import '../../utils/utility.dart';
import '../entity/error_entity.dart';

class ErrorModel extends ErrorEntity {
  const ErrorModel({
    required super.statusCode,
    required super.message,
    required super.errors,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json, {int? statusCode}) {
    return ErrorModel(
      statusCode: statusCode ?? -1000,
      message: json['MESSAGE'] ?? json['message'] ?? 'null',
      errors: checkFromMap(json['errors']) ? List.from(json['errors']) : [],
    );
  }
}
