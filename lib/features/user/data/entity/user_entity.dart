import 'package:equatable/equatable.dart';
import '../../../../../core/utils/enums/enums.dart';
import '../../../../../core/utils/enums/enums_converter.dart';
import '../../../category/data/model/category_model.dart';
import '../../../selectors/age/data/model/age_model.dart';
import '../../../selectors/banks/data/model/bank_model.dart';
import '../../../selectors/city/data/model/city_model.dart';


class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.gender,
    this.city,
    this.age,
    this.bank,
    required this.userType,
    required this.userStatus,
    required this.email,
    required this.token,
    required this.phone,
    required this.completePhone,
    required this.isVerified,
    required this.firstName,
    required this.lastName,
    required this.countryCode,
    this.commericalNumber,
    required this.allowNotification,
    required this.favoriteCategories,
    this.bankNumber,
    this.ibanNumber,
    this.isSeller,
  });

  final int id;
  final GenderTypes gender;
  final UserType userType;

  final String firstName;
  final String lastName;

  final String countryCode;
  final String phone;
  final String completePhone;
  final CityModel? city;
  final AgeModel? age;
  final BankModel? bank;

  final bool isVerified;
  final bool? allowNotification;
  final bool? isSeller;
  final String email;
  final String? commericalNumber;
  final String token;
  final String? bankNumber, ibanNumber;

  final UserStatus userStatus;
  final List<CategoryModel> favoriteCategories;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userType': UserEnumsConverter.userTypeToString(userType),
        'gender': UserEnumsConverter.genderTypeToString(gender),
        'city': city?.toJson(),
        'age': age?.toJson(),
        'bank': bank?.toJson(),
        'firstName': firstName,
        'lastName': lastName,
        'countryCode': countryCode,
        'phone': phone,
        'completePhone': completePhone,
        'commericalNumber': commericalNumber,
        'ibanNumber': ibanNumber,
        'bankNumber': bankNumber,
        'email': email,
        'isVerified': isVerified,
        'status': UserEnumsConverter.userStatusToInt(userStatus),
        'allowNotification': allowNotification,
        'isSeller': isSeller,
        'favoriteCategories':
            favoriteCategories.map((v) => v.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        id,
        userType,
        gender,
        firstName,
        lastName,
        countryCode,
        phone,
        completePhone,
        commericalNumber,
        isVerified,
        allowNotification,
        isSeller,
        email,
        token,
        userStatus,
        bank,
        ibanNumber,
        bankNumber,
        favoriteCategories,
      ];
}
