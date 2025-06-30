import 'package:equatable/equatable.dart';
import '../../../../../core/utils/enums/enums.dart';
import '../../../../../core/utils/enums/enums_converter.dart';
import '../../../../category/data/entity/category_entity.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.gender,
    required this.userType,
    required this.userStatus,
    required this.email,
    required this.token,
    required this.phone,
    required this.isVerified,
    required this.firstName,
    required this.lastName,
    required this.countryCode,
    required this.compeletePhone,
    required this.allowNotification,
    required this.favoriteCategories,
  });

  final int id;
  final GenderTypes gender;
  final UserType userType;

  final String firstName;
  final String lastName;

  final String countryCode;
  final String phone;
  final String compeletePhone;

  final bool isVerified;
  final bool? allowNotification;
  final String email;
  final String token;

  final UserStatus userStatus;
  final List<CategoryEntity> favoriteCategories;
  UserEntity copyWith({
    int? id,
    String? token,
    String? createdAt,
    UserType? userType,
    GenderTypes? gender,
    UserStatus? userStatus,
    String? email,
    String? phone,
    bool? allowNotification,
    String? compeletePhone,
    String? countryCode,
    String? firstName,
    String? lastName,
    bool? isVerified,
    List<CategoryEntity>? favoriteCategories,
  }) {
    return UserEntity(
      id: id ?? this.id,
      allowNotification: allowNotification ?? this.allowNotification,
      compeletePhone: compeletePhone ?? this.compeletePhone,
      countryCode: countryCode ?? this.countryCode,
      email: email ?? this.email,
      userType: userType ?? this.userType,
      gender: gender ?? this.gender,
      userStatus: userStatus ?? this.userStatus,
      firstName: firstName ?? this.firstName,
      isVerified: isVerified ?? this.isVerified,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      token: token ?? this.token,
      favoriteCategories: favoriteCategories ?? this.favoriteCategories,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userType': UserEnumsConverter.userTypeToString(userType),
        'gender': UserEnumsConverter.genderTypeToString(gender),
        'firstName': firstName,
        'lastName': lastName,
        'countryCode': countryCode,
        'phone': phone,
        'completePhone': compeletePhone,
        'email': email,
        'isVerified': isVerified ? '1' : '0',
        'status': UserEnumsConverter.userStatusToInt(userStatus),
        'allowNotification': allowNotification,
        'favoriteCategories': favoriteCategories,
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
        compeletePhone,
        isVerified,
        allowNotification,
        email,
        token,
        userStatus,
        favoriteCategories,
      ];
}
