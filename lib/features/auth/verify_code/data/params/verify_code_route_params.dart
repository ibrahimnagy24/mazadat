import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/enums.dart';

class VerifyCodeRouteParams extends Equatable {
  const VerifyCodeRouteParams({
    required this.phone,
    required this.countryCode,
    required this.fromScreenEnum,
  });
  final String phone;
  final String countryCode;
  final VerifyCodeFromScreen fromScreenEnum;
  @override
  List<Object?> get props => [phone, countryCode, fromScreenEnum];
}
