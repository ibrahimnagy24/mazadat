import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/app.dart';
import 'app/init_main_functions.dart';
import 'core/app_config/app_config.dart';
import 'core/app_config/flavour.dart';
import 'core/utils/utility.dart';
import 'core/utils/widgets/misc/restart_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Flavour.appFlavor = FlavorEnum.STAGING;
  AppConfig.BASE_URL = Flavour.appFlavor == FlavorEnum.STAGING
      ? AppConfig.BASE_URL_STAGING
      : AppConfig.BASE_URL_PRODUCTION;
  try {
    await initMainFunction();
  } catch (e) {
    cprint(e.toString());
  }

  try {
    await Utility.logout();
  } catch (e) {
    cprint(e.toString());
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(RestartWidget(child: const MyApp())));
}
