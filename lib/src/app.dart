import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/res/theme/themes.dart';
import 'package:escape_anchovy/src/screen/achievement/achievement_controller.dart';
import 'package:escape_anchovy/src/screen/achievement/achievement_screen.dart';
import 'package:escape_anchovy/src/screen/exercise/complete_screen.dart';
import 'package:escape_anchovy/src/screen/exercise/exercise_controller.dart';
import 'package:escape_anchovy/src/screen/exercise/exercise_screen1.dart';
import 'package:escape_anchovy/src/screen/exercise/exercise_screen2.dart';
import 'package:escape_anchovy/src/screen/exercise/timer_screen.dart';
import 'package:escape_anchovy/src/screen/home/home_controller.dart';
import 'package:escape_anchovy/src/screen/home/home_screen.dart';
import 'package:escape_anchovy/src/screen/note/note_screen.dart';
import 'package:escape_anchovy/src/screen/splash/splash_controller.dart';
import 'package:escape_anchovy/src/screen/splash/splash_screen.dart';
import 'package:escape_anchovy/src/screen/user_info/user_info_controller.dart';
import 'package:escape_anchovy/src/screen/user_info/user_info_screen.dart';
import 'package:escape_anchovy/src/screen/user_name/user_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp(
      {super.key,
      required this.splashController,
      required this.settingController,
      required this.homeController,
      required this.userInfoController,
      required this.achievementController,
      required this.exerciseController});

  final SplashController splashController;
  final SettingsController settingController;
  final HomeController homeController;
  final UserInfoController userInfoController;
  final AchievementController achievementController;
  final ExerciseController exerciseController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.settingController,
        builder: (context, snapshot) {
          return MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('ko'), Locale('en')],
            locale: Locale(widget.settingController.countryCode),
            theme: Themes.light,
            darkTheme: Themes.dark,
            themeMode: widget.settingController.themeMode,
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.app_title,
            initialRoute: SplashScreen.routeName,
            onGenerateRoute: (RouteSettings routeSettings) {
              return route(routeSettings);
            },
          );
        });
  }

  Widget returnSplashScreen() {
    if (widget.settingController.splashNum == 1) {
      return const SplashScreen(
          backgroundColor: Color(0XFF81A0FF),
          titleColor: Color(0XFFF6CA6E),
          fish: 'assets/svg/mackerel.svg',
          wave: 'assets/png/wave2.png');
    } else if (widget.settingController.splashNum == 2) {
      return const SplashScreen(
          backgroundColor: Color(0XFF6878AB),
          titleColor: Color(0XFFBCE885),
          fish: 'assets/svg/daegu.svg',
          wave: 'assets/png/wave3.png');
    } else if (widget.settingController.splashNum == 3) {
      return const SplashScreen(
          backgroundColor: Color(0XFF5F7088),
          titleColor: Color(0XFFFF5038),
          fish: 'assets/svg/shark.svg',
          wave: 'assets/png/wave4.png');
    } else {
      return const SplashScreen(
          backgroundColor: Color(0XFFC7E7FF),
          titleColor: Color(0XFF8A848D),
          fish: 'assets/svg/anchovy.svg',
          wave: 'assets/png/wave.png');
    }
  }

  MaterialPageRoute<void> route(RouteSettings routeSettings) {
    return MaterialPageRoute<void>(
        settings: routeSettings,
        builder: (BuildContext context) {
          switch (routeSettings.name) {
            case SplashScreen.routeName:
              return returnSplashScreen();
            case HomeScreen.routeName:
              return HomeScreen(
                achievementController: widget.achievementController,
                settingController: widget.settingController,
                userInfoController: widget.userInfoController,
                exerciseController: widget.exerciseController,
                homeController: widget.homeController,
              );
            case UserInfoScreen.routeName:
              return UserInfoScreen(
                  userInfoController: widget.userInfoController,
                  settingController: widget.settingController);
            case ExerciseScreen1.routeName:
              return ExerciseScreen1(
                  homeController: widget.homeController,
                  exerciseController: widget.exerciseController);
            case ExerciseScreen2.routeName:
              return ExerciseScreen2(
                  homeController: widget.homeController,
                  exerciseController: widget.exerciseController);
            case TimerScreen.routeName:
              return TimerScreen(exerciseController: widget.exerciseController);
            case CompleteScreen.routeName:
              return CompleteScreen(
                homeController: widget.homeController,
                exerciseController: widget.exerciseController,
              );
            case AchievemnetScreen.routeName:
              return AchievemnetScreen(
                  ahcievementController: widget.achievementController);
            case UserNameScreen.routeName:
              return const UserNameScreen();
            case NoteScreen.routeName:
              return const NoteScreen();
            default:
              return const Text('Error');
          }
        });
  }
}
