import 'package:easy_localization/easy_localization.dart';
import 'package:escape_anchovy/src/app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('ko', 'KR'), Locale('en', 'US')],
      path: 'assets/locale',
      fallbackLocale: Locale('ko', 'KR'),
      child: const MyApp()));
}
