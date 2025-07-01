import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/enums.dart';

class VerifyCodeParams extends Equatable {
  const VerifyCodeParams({
    required this.phone,
    this.oldPhone,
    required this.countryCode,
    required this.code,
    required this.verifyCodeFromScreen,
  });
  final String phone;
  final String? oldPhone;
  final String countryCode;
  final String code;
  final VerifyCodeFromScreen verifyCodeFromScreen;
  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'phone': countryCode + phone,
      'oldPhone': countryCode + (oldPhone ?? phone),
      'otp': code,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [phone, countryCode, code, verifyCodeFromScreen];
}
