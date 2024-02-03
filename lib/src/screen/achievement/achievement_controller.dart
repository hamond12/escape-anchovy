import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AchievementController with ChangeNotifier {
  final storage = const FlutterSecureStorage();

  late bool isClear1;
  late bool isClear2;
  late bool isClear3;
  late bool isClear4;
  late bool isClear5;
  late bool isClear6;
  late bool isClear7;
  late bool isClear8;

  Future<void> initClearList() async {
    isClear1 = true;
    isClear2 = await storage.read(key: 'mackerel') == 'true';
    isClear3 = await storage.read(key: 'daegu') == 'true';
    isClear4 = await storage.read(key: 'shark') == 'true';
    isClear5 = await storage.read(key: 'seed') == 'true';
    isClear6 = await storage.read(key: 'sprout') == 'true';
    isClear7 = await storage.read(key: 'sapling') == 'true';
    isClear8 = await storage.read(key: 'tree') == 'true';
    notifyListeners();
  }
}
