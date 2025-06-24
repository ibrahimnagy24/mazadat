import 'package:equatable/equatable.dart';

class SendCodeParams extends Equatable {
  const SendCodeParams({
    required this.phone,
    required this.countryCode,
  });
  final String phone;
  final String countryCode;

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {'phone': countryCode + phone};
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [phone, countryCode];
}
