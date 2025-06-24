abstract class Enum<T> {
  final T _value;
  const Enum(this._value);
  T get value => _value;
}

enum UserType { user, visitor }

enum UserStatus { active, inactive }

/// [fromResetPassword] for ResetPasswordScreen and [fromRegister] for RegisterScreen
/// Cuz they have the same layout and behavior but different actions
enum VerifyCodeFromScreen { fromForgetPassword, fromRegister, fromLogin }

enum FileTypeEnum { question, answer, audio, image, user_profile }

enum LangKeysConstances { ar, en }

enum MediaType { image, audio, video }

enum GenderTypes { male, female }
