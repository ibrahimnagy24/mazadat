import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../core/app_config/app_config.dart';
import '../core/app_config/flavour.dart';
import '../core/app_config/providers.dart';
import '../core/navigation/app_router.dart';
import '../core/navigation/custom_navigation.dart';
import '../core/shared/blocs/main_app_bloc.dart';
import '../core/theme/colors/styles.dart';
import '../core/translation/all_translation.dart';
import '../core/translation/translations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: ProviderList.providers,
      child: StreamBuilder<String>(
        stream: mainAppBloc.langStream,
        builder: (context, lang) {
          return MaterialApp.router(
            routerConfig: appRouter,
            debugShowCheckedModeBanner: Flavour.appFlavor == FlavorEnum.STAGING,
            scaffoldMessengerKey: CustomNavigator.scaffoldMessengerState,
            locale: Locale(allTranslations.currentLanguage),
            supportedLocales: allTranslations.supportedLocales(),
            localizationsDelegates: const [
              TranslationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            title: AppConfig.appName,
            theme: ThemeData(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                },
              ),
              appBarTheme:
                  const AppBarTheme(surfaceTintColor: AppColors.transparent),
            ),
          );
        },
      ),
    );
  }
}
