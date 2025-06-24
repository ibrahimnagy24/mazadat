import 'package:equatable/equatable.dart';

import '../../../../../core/utils/utility.dart';

class ResetPasswordModel extends Equatable {
  const ResetPasswordModel({
    required this.message,
    required this.code,
  });
  final String message;
  final dynamic code;

  factory ResetPasswordModel.fromJson(dynamic json) {
    return ResetPasswordModel(
      message: checkFromMap(json) ? (json['message'] ?? '') : json.toString(),
      code: json['code'],
    );
  }

  @override
  List<Object?> get props => [message, code];
}
