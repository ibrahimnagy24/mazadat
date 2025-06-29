import '../../../../../core/utils/enums/enums_converter.dart';
import '../../../../../core/utils/utility.dart';
import '../../../choose_category/data/model/category_model.dart';
import '../entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.userType,
    required super.gender,
    required super.userStatus,
    required super.email,
    required super.phone,
    required super.id,
    required super.token,
    required super.isVerified,
    required super.allowNotification,
    required super.compeletePhone,
    required super.countryCode,
    required super.firstName,
    required super.lastName,
    required super.favoriteCategories,
  });

  factory UserModel.fromJson(Map<String, dynamic> json,
      {String? message, String? token}) {
    return UserModel(
      id: json['id'],
      userType: UserEnumsConverter.stringToUserType(json['userType']),
      gender: UserEnumsConverter.stringToGender(json['gender']??'male'),
      userStatus: UserEnumsConverter.intToUserStatus(json['is_active']),
      email: json['email'],
      phone: json['phone'],
      compeletePhone: json['completePhone'],
      countryCode: json['countryCode'],
      token: token ?? json['TOKEN'],
      isVerified: json['isVerified'] == '1' ? true : false,
      allowNotification: json['allowNotification'] == '1' ? true : false,
      firstName: json['firstName'],
      lastName: json['lastName'],
      favoriteCategories: checkFromArray(json['favoriteCategories'])
          ? (json['favoriteCategories'] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList()
          : [],
    );
  }
}
