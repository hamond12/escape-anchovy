import 'dart:io';

import 'package:escape_anchovy/src/app.dart';
import 'package:flutter/material.dart';

class SettingsController with ChangeNotifier {
  String countryCode = Platform.localeName.split('_')[0];
  String country = Platform.localeName.split('_')[0] == 'ko' ? 'korea' : 'usa';

  Future<void> updateLocale(String newCountryCode, String newCountry) async {
    countryCode = newCountryCode;
    country = newCountry;
    notifyListeners();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsController = SettingsController();

  runApp(MyApp(settingsController: settingsController));
}
