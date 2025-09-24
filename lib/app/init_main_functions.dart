import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/services/cache/shared_helper.dart';
import '../core/services/fcm_notification/fcm_integration_helper.dart';
import '../core/services/observable/bloc_observer.dart';
import '../core/shared/blocs/main_app_bloc.dart';
import '../core/translation/all_translation.dart';
import '../core/utils/utility.dart';
import '../firebase_options.dart';

Future<void> initMainFunction() async {
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    cprint(e.toString());
  }

  try {
    // Initialize new FCM notification module
    await FCMIntegrationHelper.initializeFCM();
    FCMIntegrationHelper.getFCMToken();
  } catch (e) {
    cprint('Error initializing FCM module: $e');
  }
  try {
    await SharedHelper.init();
  } catch (e) {
    cprint(e.toString());
  }
  try {
    await allTranslations.init();
  } catch (e) {
    cprint(e.toString());
  }
  try {
    await allTranslations.init(allTranslations.currentLanguage);
  } catch (e) {
    cprint(e.toString());
  }

  Bloc.observer = BlocObserverService();
  HttpOverrides.global = MyHttpOverrides();
  try {
    mainAppBloc.getShared();
  } catch (e) {
    cprint(e.toString());
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
