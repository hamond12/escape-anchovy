import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  late bool isSelected1;
  late bool isSelected2;
  late bool isSelected3;
  late bool isSelected4;

  Future<void> deleteCategory() async {
    await storage.delete(key: 'isSelected1');
    await storage.delete(key: 'isSelected2');
    await storage.delete(key: 'isSelected3');
    await storage.delete(key: 'isSelected4');
  }

  Future<bool?> getStorageBool(String key) async {
    String? value = await storage.read(key: key);
    return value != null ? value.toLowerCase() == 'true' : null;
  }

  Future<void> loadCategory() async {
    isSelected1 = await getStorageBool('isSelected1') ?? true;
    isSelected2 = await getStorageBool('isSelected2') ?? false;
    isSelected3 = await getStorageBool('isSelected3') ?? true;
    isSelected4 = await getStorageBool('isSelected4') ?? false;
    notifyListeners();
  }

  Future<String?> getStorageString(String key) async {
    String? value = await storage.read(key: key);
    return value;
  }

  SvgPicture returnSvg2() {
    if (isSelected3 == true) {
      return SvgPicture.asset('assets/svg/push_up_color.svg');
    } else if (isSelected4 == true) {
      return SvgPicture.asset('assets/svg/nuckle_push_up_color.svg');
    } else {
      return SvgPicture.asset('');
    }
  }

  String returnCategoryName2() {
    if (isSelected3 == true) {
      return '푸쉬업';
    } else if (isSelected4 == true) {
      return '너클푸쉬업';
    } else {
      return '';
    }
  }

  int seconds = 1;
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
}
