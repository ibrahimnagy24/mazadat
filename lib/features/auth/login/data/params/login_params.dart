import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  const LoginParams({
    required this.phone,
    required this.password,
  });

  final String phone;
  final String password;
  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'countryCode': '996',
      'phone': phone,
      'password': password,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [phone, password];
}
