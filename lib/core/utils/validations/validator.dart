import 'dart:async';

import 'package:flutter/material.dart';

import '../constant/app_strings.dart';
import '../extensions/extensions.dart';

class Validator {
  var emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email);
    } else {
      sink.addError('ادخل البريد الإكتروني بشكل صحيح');
    }
  });
  var nameValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 2) {
      sink.add(name);
    } else {
      sink.addError('ادخل الاسم بشكل صحيح');
    }
  });

  var number = StreamTransformer<String, String>.fromHandlers(
      handleData: (String value, sink) {
    if (value.length > 9) {
      sink.add(value);
    } else {
      sink.addError('يجب ان يكون رقم الجوال من 10 خانات');
    }
  });

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 7) {
      sink.add(password);
    } else {
      sink.addError('يجب ان لا تقل كلمة المرور عن 8 خانات');
    }
  });

  var confirmPassWordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 7) {
      sink.add(password);
    } else {
      sink.addError('تأكيد كلمة المرور خاطئ');
    }
  });
}

class EmailValidator {
  static String? emailValidator(String? email) {
    final emailReg =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (email == null || email.isEmpty) {
      return 'AppStrings.emailCannotBeEmptyPleaseEnterAValidEmail.tr';
    }

    if (email.contains(' ')) {
      return 'AppStrings.emailCannotContainSpaces.tr';
    }

    if (!emailReg.hasMatch(email)) {
      return 'AppStrings.pleaseEnterAValidEmailFormat.tr';
    }

    return null;
  }
}

class PhoneValidator {
  static String? phoneValidator(String? phone) {
    final phoneReg = RegExp(r'^5[0-9]{8}$');

    if (phone == null || phone.isEmpty) {
      return AppStrings.phoneCannotBeEmptyPleaseEnterAValidPhone.tr;
    }

    if (!phoneReg.hasMatch(phone)) {
      return AppStrings.pleaseEnterAValidPhoneFormat.tr;
    }

    return null;
  }
}

class PasswordValidator {
  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return AppStrings.passwordCannotBeEmpty.tr;
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return AppStrings.yourPasswordMustIncludeAtLeastOneUppercaseLetter.tr;
    }

    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return AppStrings.yourPasswordMustIncludeAtLeastOneLowercaseLetter.tr;
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return AppStrings.yourPasswordMustIncludeAtLeastOneNumber.tr;
    }
    if (password.contains(' ')) {
      return AppStrings.yourPasswordCannotContainSpaces.tr;
    }
    if (password.length < 8) {
      return AppStrings.passwordIsTooShortItMustBeAtLeast8.tr;
    }

    final reg = RegExp(r'[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:' ',<>./?]');

    if (!reg.hasMatch(password)) {
      return AppStrings.yourPasswordMustIncludeAtLeastOneSpecialCharacter.tr;
    }

    return null;
  }
}

class PasswordConfirmationValidator {
  static String? passwordValidator(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return AppStrings.passwordCannotBeEmpty.tr;
    }
    if (password != confirmPassword) {
      return AppStrings.passwordsDonTMatchPleaseTryAgain.tr;
    }

    return null;
  }
}

class ChangePasswordConfirmationValidator {
  static passwordValidator(String? password, BuildContext context) {
    if (password!.length < 6) {
      return 'confirm_password'.tr;
    }
    // else if (password != context.read<PasswordBloc>().newPassword.value) {
    //   ext('confirmed_password_match_password'.tr;
    // }
    return null;
  }
}

class NameValidator {
  static String? nameValidator(var name) {
    if (name!.length < 2) {
      return 'please_enter_valid_user_name'.tr;
    }
    return null;
  }
}

class TitleValidator {
  static String? nameValidator(String? name) {
    if (name!.length < 2) {
      return 'please_enter_valid_title'.tr;
    } else if (name.contains('٠١٥') ||
        name.contains('٠١٢') ||
        name.contains('٠١١') ||
        name.contains('٠١٠') ||
        name.contains('015') ||
        name.contains('012') ||
        name.contains('011') ||
        name.contains('010') ||
        name.contains('http://') ||
        name.contains('https://')) {
      return 'please_enter_valid_title_without_phone'.tr;
    }
    return null;
  }
}

class DescriptionValidator {
  static String? descriptionValidator(String? name) {
    // String pattern = '^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z][0-9]{5}*\$';
    // String pattern = '[a-z]+^[0-9]{5}\$';
    // String pattern = '^[A-Z]{3}[A-Z]{3}[0-9]{4}\$';
    //  RegExp regExp = RegExp(pattern);
    //  if (!regExp.hasMatch(name.trim())) {
    //    cprint("RegExp Name : "+name);
    //    ext("please_enter_valid_description".tr;
    //  }
    if (name!.length < 2) {
      return 'please_enter_valid_description'.tr;
    } else if (name.contains('٠١٥') ||
        name.contains('٠١٢') ||
        name.contains('٠١١') ||
        name.contains('٠١٠') ||
        name.contains('015') ||
        name.contains('012') ||
        name.contains('011') ||
        name.contains('010') ||
        name.contains('http://') ||
        name.contains('https://')) {
      return 'please_enter_valid_description_without_phone'.tr;
    }
    return null;
  }
}

class NoteValidator {
  static String? nameValidator(String? name) {
    if (name!.length < 2) {
      return 'please_enter_valid_description'.tr;
    }
    return null;
  }
}

class PriceValidator {
  static String? priceValidator(String? price) {
    double doublePrice = double.parse(price!);
    if (doublePrice < 1) {
      return 'please_enter_valid_price'.tr;
    }
    return null;
  }
}

class PriceToValidator {
  static String? priceValidator(
      String? price, String? stringPriceFrom, BuildContext context) {
    double priceTo = double.parse(price!);
    if (priceTo > 1) {
      double priceFrom = double.parse(stringPriceFrom!);
      if (priceTo < priceFrom) {
        return 'please_enter_valid_price'.tr;
      }
    } else {
      return 'please_enter_valid_price'.tr;
    }
    return null;
  }
}

class DiscountValidator {
  static String? discountValidator(String? discount) {
    if (discount!.isEmpty || double.parse(discount) > 100.00) {
      return 'please_enter_valid_discount'.tr;
    }
    return null;
  }
}

class LinkValidator {
  static String? linkValidator(String? link) {
    if (!link!.contains('http')) {
      return 'please_enter_valid_link'.tr;
    }
    return null;
  }
}

class AddressValidator {
  static String? addressValidator(var address) {
    if (address!.length < 1) {
      return 'this_field_is_required'.tr;
    }
    return null;
  }
}

class DefaultValidator {
  static String? defaultValidator(var value, {String? label}) {
    if (value!.length < 1) {
      return label != null
          ? '$label ${AppStrings.isRequired.tr}'
          : 'this_field_is_required'.tr;
    }
    return null;
  }
}
