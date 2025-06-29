import 'package:equatable/equatable.dart';

import '../../../../../core/utils/utility.dart';

class ChangePhoneNumberModel extends Equatable {
  const ChangePhoneNumberModel({
    required this.message,
    required this.code,
  });
  final String message;
  final dynamic code;

  factory ChangePhoneNumberModel.fromJson(dynamic json) {
    return ChangePhoneNumberModel(
      message: checkFromMap(json) ? (json['message'] ?? '') : json.toString(),
      code: json['code'],
    );
  }

  @override
  List<Object?> get props => [message, code];
}
