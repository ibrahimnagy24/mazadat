import '../extensions/extensions.dart';

// validateEmail(String? value) {
//   String pattern =
//       r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(?:\.[a-zA-Z]{2,})?$';
//   RegExp regex = RegExp(pattern);
//   if (value == null || value.isEmpty || !regex.hasMatch(value)) {
//     return AppStrings.enterValidEmailAddress.tr;
//   } else if (!value.contains('.')) {
//     return AppStrings.enterValidEmailAddress.tr;
//   } else {
//     return null;
//   }
// }

// validatePassword(String? value) {
//   RegExp regex =
//       RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
//   if (value!.isEmpty) {
//     return 'AppStrings.passwordValidationMessage.tr()';
//   } else {
//     if (!regex.hasMatch(value)) {
//       return 'AppStrings.passwordValidationMessage.tr()';
//     } else {
//       return null;
//     }
//   }
// }

validatePhone(String? mobileNumber) {
  // Add your function code here!
  if (mobileNumber == null || mobileNumber.isEmpty) {
    return 'Mobile Number Is Required'.tr;
  }
  RegExp regex = RegExp(r'^(\+201|01|00201)[0-2,5]{1}[0-9]{8}$');
  if (!regex.hasMatch(mobileNumber)) {
    return 'Mobile Number Is Not Valid'.tr;
  } else {
    return null;
  }
}

Map<String, dynamic> checkPasswordStrengthAction(String? enteredPassword) {
  if (enteredPassword == null || enteredPassword.isEmpty) {
    return {};
  }
  final bool more8Char = (enteredPassword.length > 8) ? true : false;
  final bool upper = (enteredPassword.contains(RegExp(r'[A-Z]')) &&
          enteredPassword.contains(RegExp(r'[a-z]')))
      ? true
      : false;
  final bool digits =
      (enteredPassword.contains(RegExp(r'[0-9]'))) ? true : false;
  final bool hasSpecialChar = (enteredPassword
          .contains(RegExp(r'[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:' ',<>./?]')))
      ? true
      : false;
  final Map<String, bool> finalList = {
    'hasMore8Char': more8Char,
    'hasUpper': upper,
    'hasDigits': digits,
    'hasSpecialChar': hasSpecialChar,
    'accepted': more8Char && upper && hasSpecialChar && digits ? true : false,
  };
  return finalList;
}
