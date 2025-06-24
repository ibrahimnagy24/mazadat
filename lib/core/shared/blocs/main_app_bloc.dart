import 'package:rxdart/rxdart.dart';
import '../../../features/auth/login/data/entity/user_entity.dart';
import '../../services/cache/shared_helper.dart';
import '../../translation/all_translation.dart';
import '../../utils/utility.dart';

class MainAppBloc {
  final lang = BehaviorSubject<String>();
  final shared = SharedHelper();
  Function(String) get updateLang => lang.sink.add;
  Stream<String> get langStream => lang.stream.asBroadcastStream();
  String? _globalToken;
  UserEntity? _globalUserData;
  String get globalLang => allTranslations.currentLanguage;
  bool get isArabic => globalLang == 'ar';

  set setGlobalToken(String? token) => _globalToken = token;
  set setGlobalUserData(UserEntity? user) => _globalUserData = user;
  String? get globalToken => _globalToken;
  UserEntity? get globalUserData => _globalUserData;
  dispose() {
    lang.close();
  }

  getShared() async {
    cprint(
        'preferredLanguage ==> ${await allTranslations.getPreferredLanguage()}');
    String? lang;
    if (await allTranslations.getPreferredLanguage() == null ||
        await allTranslations.getPreferredLanguage() == '') {
      lang = await allTranslations.getPreferredLanguage();
      await setLanguage('ar');
      cprint('First getShared Lang............. $lang');
    } else {
      lang = await allTranslations.getPreferredLanguage() ?? 'ar';
      await setLanguage(lang!);
      cprint('Second getShared Lang............. $lang');
    }
  }

  Future<void> setLanguage(String newLanguage) async {
    updateLang(newLanguage);
    await allTranslations.setNewLanguage(newLanguage);

    cprint(allTranslations.currentLanguage.toString());
  }
}

MainAppBloc mainAppBloc = MainAppBloc();
