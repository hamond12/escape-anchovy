import 'package:flutter/material.dart';

class LightModeColors {
  static const Color background = Color(0xFFFFFFFF);
  static const Color blue = Color(0xFF5B84FF);
  static const Color red = Color(0xFFFE3F2F);
  static const Color green = Color(0xFF009300);
  static const Color gold = Color(0xFFFFD700);
  static const Color darkGold = Color(0xFFF5CD14);
  static const Color gray = Color(0xFF77717A);
  static const Color lightGray = Color(0xFFF2F2F2);
  static const Color darkGray = Color(0xFF2A2A2A);
}

// todo: 색상변경 필요
class DarkModeColors {
  static const Color background = Color(0xFF000000);
  static const Color blue = Color(0xFF5B84FF);
  static const Color red = Color(0xFFFE3F2F);
  static const Color green = Color(0xFF009300);
  static const Color gold = Color(0xFFFFD700);
  static const Color darkGold = Color(0xFFF5CD14);
  static const Color gray = Color(0xFF77717A);
  static const Color lightGray = Color(0xFFF2F2F2);
  static const Color darkGray = Color(0xFF2A2A2A);
}

extension ThemeExtension on BuildContext {
  bool get isLight => Theme.of(this).brightness == Brightness.light;
}
