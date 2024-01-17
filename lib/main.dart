import 'dart:io';

import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/src/app.dart';
import 'package:escape_anchovy/src/screen/main/home_controller.dart';
import 'package:flutter/material.dart';

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
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController();
  final homeController = HomeController();
  runApp(MyApp(
    settingsController: settingsController,
    homeController: homeController,
  ));
}
