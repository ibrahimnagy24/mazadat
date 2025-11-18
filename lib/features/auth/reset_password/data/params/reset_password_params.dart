import 'package:equatable/equatable.dart';

class ResetPasswordParams extends Equatable {
  const ResetPasswordParams({
    required this.password,
    required this.otp,
    required this.phone,
  });
  final String password;
  final String otp;
  final String phone;

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'password': password,
      'otp': otp,
      'phone': phone,
      'countryCode': '966',
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [password, otp, phone];
}
