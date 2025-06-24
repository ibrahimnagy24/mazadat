import 'package:equatable/equatable.dart';

import '../../../choose_category/data/entity/category_entity.dart';

class RegisterParams extends Equatable {
  const RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.password,
    required this.categories,
    this.email,
  });

  final String firstName;
  final String lastName;
  final String phone;
  final String? email;
  final String password;
  final List<CategoryEntity> categories;
  Map<String, dynamic> returnedMap() {
    final favCategories = categories.map((e) => {'id': e.id}).toList();
    Map<String, dynamic> map = {
      'firstName': firstName,
      'lastName': lastName,
      'countryCode': '996',
      'phone': phone,
      'isTermsAccepted': '1',
      'email': email,
      'password': password,
      'favoriteCategories': favCategories,
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
        categories,
      ];
}
