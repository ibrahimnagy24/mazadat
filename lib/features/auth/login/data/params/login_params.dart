import 'package:equatable/equatable.dart';
import '../../../../../core/services/fcm_notification/fcm_integration_helper.dart';

class LoginParams extends Equatable {
  const LoginParams({
    required this.phone,
    required this.password,
  });

  final String phone;
  final String password;
  Map<String, dynamic> returnedMap() {
    String? token = FCMIntegrationHelper.getFCMToken();
    Map<String, dynamic> map = {
      'countryCode': '966',
      'phone': phone,
      'password': password,
      'fcmToken': token,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [phone, password];
}
