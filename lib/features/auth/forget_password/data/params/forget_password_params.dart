import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/enums.dart';

class ForgetPasswordParams extends Equatable {
  const ForgetPasswordParams({
    required this.phone,
    required this.countryCode,
    required this.fromScreenEnum,
  });
  final String phone;
  final String countryCode;
  final VerifyCodeFromScreen fromScreenEnum;
  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {'phone': '$countryCode$phone'};
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [phone, countryCode, fromScreenEnum];
}
