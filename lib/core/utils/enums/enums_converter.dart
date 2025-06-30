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

  static GenderTypes stringToGender(String value) {
    switch (value) {
      case 'male':
        return GenderTypes.male;
      default:
        return GenderTypes.female;
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

  static String genderTypeToString(GenderTypes value) {
    switch (value) {
      case GenderTypes.male:
        return 'MALE';
      case GenderTypes.female:
        return 'FEMALE';
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

class CategoryTypeConverter {
  static String categoryTypeToString(CategoryTypes value) {
    switch (value) {
      case CategoryTypes.auction:
        return 'AUCTION';
      case CategoryTypes.bundle:
        return 'BUNDLE';
    }
  }

  static CategoryTypes stringToCategoryType(String value) {
    switch (value) {
      case 'bundle':
        return CategoryTypes.bundle;
      default:
        return CategoryTypes.auction;
    }
  }
}
