import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/enums.dart';

class ChangePasswordRouteParams extends Equatable {
  final String phone;
  final String code;
  final ChangePasswordFromScreen fromScreenEnum;

  const ChangePasswordRouteParams({
    required this.phone,
    required this.code,
    required this.fromScreenEnum,
  });

  @override
  List<Object?> get props => [phone, code, fromScreenEnum];
}
