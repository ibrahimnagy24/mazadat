import 'package:equatable/equatable.dart';
import '../../../../../core/utils/enums/enums.dart';

class RegisterParams extends Equatable {
  const RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.password,
    required this.email,
    this.gender,
    this.city,
    this.age,
  });

  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;
  final GenderTypes? gender;
  final int? city, age;
  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'firstName': firstName,
      'lastName': lastName,
      'countryCode': '966',
      'phone': phone,
      'isTermsAccepted': '1',
      'email': email,
      if (gender != null) 'gender': gender?.name[0].toUpperCase(),
     if(city != null) 'city': {'id': city},
      if(age != null)  'age': {'id': age},
      'password': password,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        phone,
        email,
        password,
        city,
        gender,
        age,
      ];
}
