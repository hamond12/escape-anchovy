import 'dart:io';

import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/src/app.dart';
import 'package:escape_anchovy/src/screen/home/home_controller.dart';
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

  Future<void> initialTheme(BuildContext context) async {
    theme = context.isLight ? 'light_mode' : 'dark_mode';
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode, String newTheme) async {
    themeMode = newThemeMode!;
    theme = newTheme;
    notifyListeners();
  }

  final storage = const FlutterSecureStorage();

  late bool isMackerel;
  Future<void> initIsMackerel() async {
    isMackerel = await storage.read(key: 'mackerel') == 'true';
    notifyListeners();
  }

  late int splashNum;
  Future<void> initSplashNum() async {
    if (await storage.read(key: 'mackerel') == 'true' &&
        await storage.read(key: 'daegu') == null &&
        await storage.read(key: 'shark') == null) {
      splashNum = 1;
    } else if (await storage.read(key: 'mackerel') == 'true' &&
        await storage.read(key: 'daegu') == 'true' &&
        await storage.read(key: 'shark') == null) {
      splashNum = 2;
    } else if (await storage.read(key: 'mackerel') == 'true' &&
        await storage.read(key: 'daegu') == 'true' &&
        await storage.read(key: 'shark') == 'true') {
      splashNum = 3;
    } else {
      splashNum = 0;
    }
    notifyListeners();
  }
}

int splashNum = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsController = SettingsController();
  final homeController = HomeController();

  await settingsController.initIsMackerel();
  await settingsController.initSplashNum();

  print(settingsController.splashNum);

  runApp(MyApp(
    settingsController: settingsController,
    homeController: homeController,
  ));
}
