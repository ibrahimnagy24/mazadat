import 'package:equatable/equatable.dart';

class DeleteAccountParams extends Equatable {
  const DeleteAccountParams({required this.password});

  final String password;
  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'type': 'PASSWORD',
      'value': password,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [password];
}
