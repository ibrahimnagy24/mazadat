import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../features/auth/login/data/entity/user_entity.dart';
import '../../../features/auth/login/data/model/user_model.dart';
import '../../navigation/custom_navigation.dart';
import '../../navigation/routes.dart';
import '../../shared/blocs/main_app_bloc.dart';
import '../../translation/all_translation.dart';
import '../../utils/enums/enums.dart';
import '../../utils/utility.dart';

class CachingKey extends Enum<String> {
  const CachingKey(super.val);
  static const CachingKey USER = CachingKey('USER');
  static const CachingKey USER_TYPE = CachingKey('USER_TYPE');
  static const CachingKey TOKEN = CachingKey('REAL_TOKEN');
  static const CachingKey LANG = CachingKey('LANG');
  static const CachingKey SOCIAL = CachingKey('SOCIAL');
  static const CachingKey IS_LOGIN = CachingKey('IS_LOGIN');
  static const CachingKey USER_LAT = CachingKey('USER_LAT');
  static const CachingKey USER_LONG = CachingKey('USER_LONG');
  static const CachingKey CHECK_LOCATION = CachingKey('CHECK_LOCATION');
  static const CachingKey ADDRESS = CachingKey('ADDRESS');
  static const CachingKey DEVICE_TOKEN = CachingKey('DEVICE_TOKEN');
}

class SharedHelper {
  static SharedHelper? sharedHelper;
  static Box? box;

  static init() async {
    if (box == null) {
      await Hive.initFlutter();
      box = await Hive.openBox('testBox');
      sharedHelper = SharedHelper();
    }
  }

  Future<void> clear() async {
    await box?.clear();
  }

//------------------------------USER OPERATIONS-------------------------------\\
  Future<void> saveToken(String token, {bool needToCacheToken = true}) async {
    if (needToCacheToken) {
      try {
        await writeData(CachingKey.TOKEN, token);
        getToken();
      } catch (e) {
        cprint('Error saving token: $e');
      }
    } else {
      mainAppBloc.setGlobalToken = token;
    }
  }

  Future<void> saveUser(UserEntity user) async {
    try {
      await writeData(CachingKey.USER, jsonEncode(user.toJson()));
      getUser();
    } catch (e) {
      cprint('Error saving user: $e');
    }
  }

  UserEntity? getUser() {
    try {
      final userJson = box?.get(CachingKey.USER.value);
      if (userJson != null) {
        mainAppBloc.setGlobalUserData =
            UserModel.fromJson(jsonDecode(userJson));
        return mainAppBloc.globalUserData;
      }
      return null;
    } catch (e) {
      cprint('Error getting user: $e');
      return null;
    }
  }

  String? getToken() {
    try {
      mainAppBloc.setGlobalToken =
          box?.get(CachingKey.TOKEN.value) ?? mainAppBloc.globalToken;
      return mainAppBloc.globalToken;
    } catch (e) {
      cprint('Error getting token: $e');
      return null;
    }
  }

  Future<void> cacheLoginData(UserEntity user) async {
    try {
      await saveToken(user.token);
      await saveUser(user);
    } catch (e) {
      cprint('Error saving user cacheLoginData: $e');
    }
  }

  Future<void> clearCachedLogin() async {
    try {
      await box?.delete(CachingKey.TOKEN.value);
      await box?.delete(CachingKey.USER.value);
      mainAppBloc.setGlobalToken = null;
      mainAppBloc.setGlobalUserData = null;
    } catch (e) {
      cprint('Error saving user clearCachedLogin: $e');
    }
  }

//-----------------------------OTHERS OPERATIONS-------------------------------\\

  Future<void> changeLanguage(String lang) async {
    await allTranslations.setNewLanguage(lang, true);
    await allTranslations.setPreferredLanguage(lang);
    await writeData(CachingKey.LANG, lang);
  }

  Future<void> logout() async {
    await clear();
    final currentLang = await allTranslations.getPreferredLanguage();
    await writeData(CachingKey.IS_LOGIN, false);
    await changeLanguage(currentLang);
    CustomNavigator.push(Routes.SPLASH, replace: true);
  }

  Future<void> writeData(CachingKey key, dynamic value) async {
    await box?.put(key.value, value);
  }

  Future<bool> readBoolean(CachingKey key) async =>
      box?.get(key.value) ?? false;

  Future<double> readDouble(CachingKey key) async => box?.get(key.value) ?? 0.0;

  Future<int> readInteger(CachingKey key) async => box?.get(key.value) ?? 0;

  Future<String> readString(CachingKey key) async => box?.get(key.value) ?? '';
  Future<void> removeData(CachingKey key) async {
    await box?.delete(key.value);
  }
}
