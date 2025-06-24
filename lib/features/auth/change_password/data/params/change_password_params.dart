import 'package:equatable/equatable.dart';

class ChangePasswordParams extends Equatable {
  const ChangePasswordParams({
    required this.newPassword,
    required this.comfirmPassword,
    required this.email,
  });
  final String newPassword;
  final String comfirmPassword;
  final String email;

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'password': newPassword,
      'password_confirmation': comfirmPassword,
      'email': email,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [newPassword, comfirmPassword];
}
