import '../../../../../core/utils/enums/enums_converter.dart';
import '../../../../../core/utils/utility.dart';
import '../../../category/data/model/category_model.dart';
import '../../../selectors/age/data/model/age_model.dart';
import '../../../selectors/banks/data/model/bank_model.dart';
import '../../../address/city/data/model/city_model.dart';
import '../entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.age,
    super.city,
    required super.userType,
    required super.gender,
    required super.userStatus,
    required super.email,
    required super.phone,
    required super.completePhone,
    required super.id,
    required super.token,
    required super.isVerified,
    required super.allowNotification,
    super.commericalNumber,
    required super.countryCode,
    required super.firstName,
    required super.lastName,
    required super.favoriteCategories,
    super.bank,
    super.bankNumber,
    super.ibanNumber,
    super.isSeller,
  });

  factory UserModel.fromJson(Map<String, dynamic> json,
      {String? message, String? token}) {
    return UserModel(
      id: json['id'],
      userType: UserEnumsConverter.stringToUserType(json['userType']),
      gender: UserEnumsConverter.stringToGender(json['gender'] ?? 'M'),
      userStatus: UserEnumsConverter.intToUserStatus(json['is_active']),
      email: json['email'],
      phone: json['phone'],
      completePhone: json['completePhone'],
      commericalNumber: json['commericalNumber'],
      countryCode: json['countryCode'],
      token: token ?? (json['TOKEN']) ?? '',
      isVerified: json['isVerified'] == '1' ? true : false,
      allowNotification: json['allowNotification'] == '1' ? true : false,
      isSeller: json['isSeller'] == '1' ? true : false,
      firstName: json['firstName'],
      lastName: json['lastName'],
      city:
          checkFromMap(json['city']) ? CityModel.fromJson(json['city']) : null,
      age: checkFromMap(json['age']) ? AgeModel.fromJson(json['age']) : null,
      bank:
          checkFromMap(json['bank']) ? BankModel.fromJson(json['bank']) : null,
      bankNumber: json['bankNumber'],
      ibanNumber: json['ibanNumber'],
      favoriteCategories: checkFromArray(json['favoriteCategories'])
          ? (json['favoriteCategories'] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList()
          : [],
    );
  }
}
