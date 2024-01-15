import 'package:escape_anchovy/res/text/colors.dart';
import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: LightModeColors.background,
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: LightModeColors.blue),
  );
  static final dark = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: DarkModeColors.background,
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: DarkModeColors.blue));
}
