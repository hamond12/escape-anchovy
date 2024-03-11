import 'dart:io';

import 'package:escape_anchovy/notification.dart';
import 'package:escape_anchovy/src/app.dart';
import 'package:escape_anchovy/src/screen/achievement/achievement_controller.dart';
import 'package:escape_anchovy/src/screen/exercise/exercise_controller.dart';
import 'package:escape_anchovy/src/screen/home/home_controller.dart';
import 'package:escape_anchovy/src/screen/user_info/user_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsController with ChangeNotifier {
  String countryCode = Platform.localeName.split('_')[0];
  String country = Platform.localeName.split('_')[0] == 'ko' ? 'korea' : 'usa';

  Future<void> updateLocale(String newCountryCode, String newCountry) async {
    countryCode = newCountryCode;
    country = newCountry;
    notifyListeners();
  }

  ThemeMode themeMode = ThemeMode.system;
  String theme = '';

  Future<void> updateThemeMode(ThemeMode? newThemeMode, String newTheme) async {
    themeMode = newThemeMode!;
    theme = newTheme;
    notifyListeners();
  }

  final storage = const FlutterSecureStorage();

  late int splashNum;
  Future<void> initSplashNum() async {
    if ((await storage.read(key: 'mackerel') == null &&
            await storage.read(key: 'deagu') == null &&
            await storage.read(key: 'shark') == null) ||
        await storage.read(key: 'anchovy_medal') == 'true') {
      splashNum = 0;
    } else if ((await storage.read(key: 'mackerel') == 'true' &&
            await storage.read(key: 'deagu') == null &&
            await storage.read(key: 'shark') == null) ||
        await storage.read(key: 'mackerel_medal') == 'true') {
      splashNum = 1;
    } else if (await storage.read(key: 'daegu_medal') == 'true') {
      splashNum = 2;
    } else if (await storage.read(key: 'shark_medal') == 'true') {
      splashNum = 3;
    }
    notifyListeners();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();

  final homeController = HomeController();
  final settingController = SettingsController();
  final userInfoController = UserInfoController();
  final achievementController = AchievementController();
  final exerciseController = ExerciseController();

  await homeController.initIsMackerel();
  await settingController.initSplashNum();

  runApp(MyApp(
    settingController: settingController,
    homeController: homeController,
    userInfoController: userInfoController,
    achievementController: achievementController,
    exerciseController: exerciseController,
  ));
}
