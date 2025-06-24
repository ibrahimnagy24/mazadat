import 'enums.dart';

class UserEnumsConverter {
  static UserType stringToUserType(String value) {
    switch (value) {
      case 'user':
        return UserType.user;
      default:
        return UserType.visitor;
    }
  }

  static String userTypeToString(UserType value) {
    switch (value) {
      case UserType.user:
        return 'USER';
      case UserType.visitor:
        return 'visitor';
    }
  }

  static UserStatus intToUserStatus(int? value) {
    switch (value) {
      case 1:
        return UserStatus.active;
      case 0:
        return UserStatus.inactive;
      default:
        return UserStatus.active;
    }
  }

  static int userStatusToInt(UserStatus value) {
    switch (value) {
      case UserStatus.active:
        return 1;
      case UserStatus.inactive:
        return 0;
    }
  }
}

class GenderTypeConverter {
  static GenderTypes? stringToGenderType(String? gender) {
    switch (gender) {
      case 'male':
        return GenderTypes.male;
      case 'female':
        return GenderTypes.female;
      default:
        return null;
    }
  }
}
