import 'package:equatable/equatable.dart';
import '../../../../../core/utils/enums/enums.dart';
import '../../../category/data/entity/category_entity.dart';

class EditFavouriteCategoriesParams extends Equatable {
  const EditFavouriteCategoriesParams({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.categories,
    required this.gender,
    required this.city,
    required this.age,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final GenderTypes gender;
  final int city, age;

  final List<CategoryEntity> categories;

  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'countryCode': '996', // Without +
      'phone': phone,
      'imageId': '',
      'gender': gender.name[0].toUpperCase(),
      'city': {'id': city},
      'age': {'id': age},
      'favoriteCategories':
          categories.map((e) => e.returnedCategoryIdMap()).toList(),
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
        categories,
      ];
}
