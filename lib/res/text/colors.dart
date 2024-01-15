import 'package:flutter/material.dart';

class LightModeColors {
  static const Color background = Color(0xFFFFFFFF);
  static const Color blue = Color(0xFF5B84FF);
  static const Color red = Color(0xFFFE3F2F);
  static const Color green = Color(0xFF009300);
  static const Color gold = Color(0xFFFFD700);
  static const Color darkGold = Color(0xFFF5CD14);
  static const Color dark1 = Color(0xFF202020);
  static const Color dark2 = Color(0xFF3E3E3E);
  static const Color dark3 = Color(0xFF8A848D);
  static const Color dark4 = Color(0xFFF2F2F2);
}

class DarkModeColors {
  static const Color background = Color(0xFF000000);
  static const Color blue = Color(0xFF79A2FF);
  static const Color red = Color(0xFFFF5D4D);
  static const Color green = Color(0xFF1EB11E);
  static const Color darkGold = Color(0xFFE9C332);
  static const Color dark1 = Color(0xFFF2F2F2);
  static const Color dark2 = Color(0xFFCDCDCD);
  static const Color dark3 = Color(0xFF948E97);
  static const Color dark4 = Color(0xFF2A2A2A);
}

extension ThemeExtension on BuildContext {
  bool get isLight => Theme.of(this).brightness == Brightness.light;
}
