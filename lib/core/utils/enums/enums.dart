abstract class Enum<T> {
  final T _value;
  const Enum(this._value);
  T get value => _value;
}

enum UserType { user, visitor }

enum UserStatus { active, inactive }

/// [fromResetPassword] for ResetPasswordScreen and [fromRegister] for RegisterScreen
/// Cuz they have the same layout and behavior but different actions
enum VerifyCodeFromScreen {
  fromForgetPassword,
  fromRegister,
  fromLogin,
  fromChangePhoneNumber
}

enum FileTypeEnum { question, answer, audio, image, user_profile }

enum LangKeysConstances { en, ar }

enum MediaType { image, audio, video }

enum GenderTypes { male, female }

enum CategoryTypes { auction, bundle }

enum BiddingMethod { auto, manual }

enum WalletHistoryType { deposit, withdraw }

enum ChangePasswordFromScreen { fromForgetPassword, fromEditProfile }

enum AuctionType { private, public }
