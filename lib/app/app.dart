import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../core/app_config/app_config.dart';
import '../core/app_config/flavour.dart';
import '../core/app_config/providers.dart';
import '../core/assets/app_launchers.dart';
import '../core/navigation/app_router.dart';
import '../core/navigation/custom_navigation.dart';
import '../core/services/notification_pusher/notification_pusher_wrapper.dart';
import '../core/services/toast_service.dart';
import '../core/shared/blocs/main_app_bloc.dart';
import '../core/theme/colors/styles.dart';
import '../core/theme/text_styles/text_styles.dart';
import '../core/translation/all_translation.dart';
import '../core/translation/translations.dart';
import '../core/utils/constant/app_strings.dart';
import '../core/utils/extensions/extensions.dart';
import '../core/utils/utility.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: ProviderList.providers,
      child: StreamBuilder<String>(
        stream: mainAppBloc.langStream,
        builder: (context, lang) {
          return GlobalLoaderOverlay(
            overlayWidgetBuilder: (progress) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppLaunchers.logo,
                  color: AppColors.kPrimary,
                  height: MediaQuery.of(context).size.width * .25,
                  width: MediaQuery.of(context).size.width * .25,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 18,
                  ),
                  child: Text(
                    AppStrings.loading.tr,
                    style: AppTextStyles.textLgMedium,
                  ),
                ),
              ],
            ),
            child: NotificationPusherWrapper(
              onConnectionStateChanged: (state) {
                cprint('onConnectionStateChanged $state');
              },
              onGeneralNotification: (p0) {
                cprint('onGeneralNotification $p0');
                ToastService.showCustom(
                  message: p0.notificationData.title ?? 'no title',
                  context: CustomNavigator.context,
                  toastStatusType: ToastStatusType.success,
                );
              },
              onUserNotification: (p0) {
                cprint('onUserNotification $p0');
                ToastService.showCustom(
                  message: p0.notificationData.title ?? 'no title',
                  context: CustomNavigator.context,
                  toastStatusType: ToastStatusType.success,
                );
              },
              child: MaterialApp.router(
                routerConfig: appRouter,
                debugShowCheckedModeBanner:
                    Flavour.appFlavor == FlavorEnum.STAGING,
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
                  primaryColor: AppColors.kPrimary,
                  colorScheme: const ColorScheme.light(
                    primary: AppColors.kPrimary,
                    secondary: AppColors.kPrimary300,
                  ),
                  checkboxTheme: CheckboxThemeData(
                    overlayColor: WidgetStateProperty.all<Color>(
                        AppColors.kPrimary.withOpacity(0.1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // fontFamily: 'en',
                  appBarTheme: const AppBarTheme(
                      surfaceTintColor: AppColors.transparent),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
