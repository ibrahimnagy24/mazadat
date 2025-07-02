import 'package:equatable/equatable.dart';

import '../../../../../core/utils/utility.dart';

class ForgetPasswordModel extends Equatable {
  const ForgetPasswordModel({
    required this.message,
    required this.code,
  });
  final String message;
  final dynamic code;

  factory ForgetPasswordModel.fromJson(dynamic json) {
    return ForgetPasswordModel(
      message: checkFromMap(json) ? (json['message'] ?? '') : json.toString(),
      code: json['code'],
    );
  }

  @override
  List<Object?> get props => [message, code];
}
