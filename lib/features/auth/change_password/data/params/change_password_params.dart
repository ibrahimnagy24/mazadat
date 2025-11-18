import 'package:equatable/equatable.dart';

class ChangePasswordParams extends Equatable {
  const ChangePasswordParams({
    required this.newPassword,
    required this.oldPassword,
  });
  final String newPassword;
  final String oldPassword;

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'password': newPassword,
      'oldPassword': oldPassword,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [newPassword, oldPassword];
}
