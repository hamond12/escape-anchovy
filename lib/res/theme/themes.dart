import 'package:escape_anchovy/res/text/colors.dart';
import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: LightModeColors.background,
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: LightModeColors.blue),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: DarkModeColors.background),
      bodyMedium: TextStyle(color: DarkModeColors.background),
      bodySmall: TextStyle(color: DarkModeColors.background),
    ),
  );
  static final dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: DarkModeColors.background,
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: DarkModeColors.blue),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: LightModeColors.background),
      bodyMedium: TextStyle(color: LightModeColors.background),
      bodySmall: TextStyle(color: LightModeColors.background),
    ),
  );
}
