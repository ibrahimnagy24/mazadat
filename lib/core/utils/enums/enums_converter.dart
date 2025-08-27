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

  static GenderTypes stringToGender(String value) {
    switch (value) {
      case 'M':
        return GenderTypes.male;
      default:
        return GenderTypes.female;
    }
  }

  static String genderTypeToString(GenderTypes value) {
    switch (value) {
      case GenderTypes.male:
        return 'M';
      case GenderTypes.female:
        return 'F';
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

class BiddingMethodConverter {
  static BiddingMethod? stringToBiddingMethod(String? value) {
    switch (value) {
      case 'MANUAL':
        return BiddingMethod.manual;
      case 'AUTO':
        return BiddingMethod.auto;
      default:
        return null;
    }
  }

  static String BiddingMethodToString(BiddingMethod value) {
    switch (value) {
      case BiddingMethod.manual:
        return 'MANUAL';
      case BiddingMethod.auto:
        return 'AUTO';
    }
  }
}

abstract class AuctionEnumConverter {
  static AuctionType stringToAuctionType(String value) {
    switch (value.toUpperCase()) {
      case 'PRIVATE':
        return AuctionType.private;
      default:
        return AuctionType.public;
    }
  }

  static String AuctionTypeToString(AuctionType value) {
    switch (value) {
      case AuctionType.private:
        return AuctionType.private.name.toUpperCase();
      case AuctionType.public:
        return AuctionType.public.name.toUpperCase();
    }
  }
}
