import 'package:equatable/equatable.dart';
import '../../../../../core/utils/enums/enums.dart';

class EditProfileParams extends Equatable {
  const EditProfileParams({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    this.gender,
    this.city,
    this.age,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final GenderTypes? gender;
  final int? city, age;
  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'countryCode': '996', // Without +
      'phone': phone,
      'imageId': '',
      if (gender != null) 'gender': gender?.name[0].toUpperCase(),
      if (city != null) 'city': {'id': city},
      if (age != null) 'age': {'id': age},
      // "favoriteCategories":[ {"id": 1},{"id":3},{"id":5}],
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        city,
        gender,
        age,
      ];
}
