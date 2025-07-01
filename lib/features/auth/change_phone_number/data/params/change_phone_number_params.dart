import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/enums.dart';

class ChangePhoneNumberParams extends Equatable {
  const ChangePhoneNumberParams({
    required this.phone,
    required this.oldPhone,
    required this.countryCode,
    required this.fromScreenEnum,
  });
  final String phone, oldPhone;
  final String countryCode;
  final VerifyCodeFromScreen fromScreenEnum;
  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'countryCode': countryCode,
      'phone': phone,
      'oldPhone': oldPhone
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [phone, oldPhone, countryCode, fromScreenEnum];
}
