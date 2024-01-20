import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/res/theme/themes.dart';
import 'package:escape_anchovy/src/screen/home/home_controller.dart';
import 'package:escape_anchovy/src/screen/home/home_screen.dart';
import 'package:escape_anchovy/src/screen/note/note_screen.dart';
import 'package:escape_anchovy/src/screen/splash/splash_screen.dart';
import 'package:escape_anchovy/src/screen/user_info/user_info_screen.dart';
import 'package:escape_anchovy/src/screen/user_name/user_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp(
      {super.key,
      required this.settingsController,
      required this.homeController});

  final SettingsController settingsController;
  final HomeController homeController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    widget.settingsController.initialTheme(context);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.settingsController,
        builder: (context, snapshot) {
          return MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('ko'), Locale('en')],
            locale: Locale(widget.settingsController.countryCode),
            theme: Themes.light,
            darkTheme: Themes.dark,
            themeMode: widget.settingsController.themeMode,
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
              return HomeScreen(
                controller: widget.settingsController,
              );
            case UserInfoScreen.routeName:
              return UserInfoScreen(controller: widget.settingsController);
            case UserNameScreen.routeName:
              return const UserNameScreen();
            case NoteScreen.routeName:
              return NoteScreen();
            default:
              return const SplashScreen();
          }
        });
  }
}
