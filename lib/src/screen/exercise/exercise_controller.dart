import 'dart:async';
import 'dart:convert';

import 'package:escape_anchovy/src/screen/exercise/exercise_screen1.dart';
import 'package:escape_anchovy/src/screen/exercise/exercise_screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ExerciseController with ChangeNotifier {
  final storage = const FlutterSecureStorage();
  List<Map<String, dynamic>> dataList = [];

  int set = 1;

  Future<void> loadData() async {
    final String? jsonData = await storage.read(key: 'dataList');
    if (jsonData != null) {
      dataList = List<Map<String, dynamic>>.from(json.decode(jsonData));
      notifyListeners();
    }
  }

  String num1 = '';
  String num2 = '';

  List ex1 = [];
  List ex2 = [];

  Future<void> addEx1() async {
    ex1.add(num1);
    await storage.write(key: 'ex1', value: ex1.join(','));
    notifyListeners();
  }

  Future<void> loadEx1() async {
    String? ex1String = await storage.read(key: 'ex1');
    if (ex1String!.isNotEmpty) {
      for (String str in ex1String.split(',')) {
        ex1.add(int.parse(str));
      }
      notifyListeners();
    }
  }

  Future<void> addEx2() async {
    ex2.add(num2);
    await storage.write(key: 'ex2', value: ex2.join(','));
    notifyListeners();
  }

  Future<void> loadEx2() async {
    String? ex2String = await storage.read(key: 'ex2');
    if (ex2String!.isNotEmpty) {
      for (String str in ex2String.split(',')) {
        ex2.add(int.parse(str));
      }
      notifyListeners();
    }
  }

  Future<void> deleteEx() async {
    await storage.delete(key: 'ex1');
    await storage.delete(key: 'ex2');
    notifyListeners();
  }

  Future<void> saveData() async {
    final String jsonData = json.encode(dataList);
    await storage.write(key: 'dataList', value: jsonData);
  }

  Future<void> deleteCategory() async {
    await storage.delete(key: 'isSelected1');
    await storage.delete(key: 'isSelected2');
    await storage.delete(key: 'isSelected3');
    await storage.delete(key: 'isSelected4');
  }

  int seconds = 120;
  late Timer timer;

  String formatTime(int second) {
    int minutes = second ~/ 60;
    int seconds = second % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  late bool isMackerel;
  void initIsMackerel() async {
    isMackerel = await storage.read(key: 'mackerel') == 'true';
    notifyListeners();
  }

  String weight = '0';
  Future<void> initWeight() async {
    String? storedWeight = await storage.read(key: 'weight');
    weight = storedWeight ?? '0';
    notifyListeners();
  }

  Future<void> deleteWeight() async {
    await storage.delete(key: 'weight');
    notifyListeners();
  }

  void moveScreen(context, set) {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (seconds == 0) {
        timer.cancel();
        if (set % 2 != 0) {
          Navigator.pushNamed(context, ExerciseScreen1.routeName);
        } else {
          Navigator.pushNamed(context, ExerciseScreen2.routeName);
        }
      } else {
        seconds--;
      }
    });
  }

  double needleRotate = 0;
  double needleTopPos = 0;
  double needleRightPos = 0;
  double needleLeftPos = 0;

  void moveTimerNeedle() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      needleRotate += 3;

      if (needleRotate <= 90) {
        needleLeftPos += 1.33;
        needleTopPos += 1;
      }

      if (needleRotate > 90 && needleRotate <= 180) {
        needleLeftPos -= 1.33;
        needleTopPos += 1;
      }

      if (needleRotate > 180 && needleRotate <= 270) {
        needleRightPos += 1.33;
        needleTopPos -= 1;
      }

      if (needleRotate > 270) {
        needleRightPos -= 1.33;
        needleTopPos -= 1;
      }

      notifyListeners();
    });
  }
}
