import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/res/theme/themes.dart';
import 'package:escape_anchovy/src/screen/main/home_screen.dart';
import 'package:escape_anchovy/src/screen/splash/splash_screen.dart';
import 'package:escape_anchovy/src/screen/user_info/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: settingsController,
        builder: (context, snapshot) {
          return MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('ko'), Locale('en')],
            locale: Locale(settingsController.countryCode),
            theme: Themes.light,
            darkTheme: Themes.dark,
            themeMode: ThemeMode.light,
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.app_title,
            initialRoute: SplashScreen.routeName,
            onGenerateRoute: (RouteSettings routeSettings) {
              return route(routeSettings);
            },
          );
        });
  }

  MaterialPageRoute<void> route(RouteSettings routeSettings) {
    return MaterialPageRoute<void>(
        settings: routeSettings,
        builder: (BuildContext context) {
          switch (routeSettings.name) {
            case SplashScreen.routeName:
              return const SplashScreen();
            case HomeScreen.routeName:
              return const HomeScreen();
            case UserInfoScreen.routeName:
              return UserInfoScreen(controller: settingsController);
            default:
              return const SplashScreen();
          }
        });
  }
}
