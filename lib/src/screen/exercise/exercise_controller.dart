import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExerciseController with ChangeNotifier {
  final storage = const FlutterSecureStorage();
  List<Map<String, dynamic>> dataList = [];

  String isSelected1 = '';
  String isSelected2 = '';
  String isSelected3 = '';
  String isSelected4 = '';

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

  Future<void> loadCategory1() async {
    isSelected1 = await getStorageString('isSelected1') ?? 'true';
    isSelected2 = await getStorageString('isSelected2') ?? 'false';
    notifyListeners();
  }

  Future<void> loadCategory2() async {
    isSelected3 = await getStorageString('isSelected3') ?? 'true';
    isSelected4 = await getStorageString('isSelected4') ?? 'false';
    notifyListeners();
  }

  Future<String?> getStorageString(String key) async {
    String? value = await storage.read(key: key);
    return value;
  }

  SvgPicture returnSvg1() {
    if (isSelected1 == 'true') {
      return SvgPicture.asset('assets/svg/pull_up_color.svg');
    } else if (isSelected2 == 'true') {
      return SvgPicture.asset('assets/svg/chin_up_color.svg');
    } else {
      return SvgPicture.asset('');
    }
  }

  SvgPicture returnSvg2() {
    if (isSelected3 == 'true') {
      return SvgPicture.asset('assets/svg/push_up_color.svg');
    } else if (isSelected4 == 'true') {
      return SvgPicture.asset('assets/svg/nuckle_push_up_color.svg');
    } else {
      return SvgPicture.asset('');
    }
  }

  String returnCategoryName1() {
    if (isSelected1 == 'true') {
      return '풀업';
    } else if (isSelected2 == 'true') {
      return '친업';
    } else {
      return '';
    }
  }

  String returnCategoryName2() {
    if (isSelected3 == 'true') {
      return '푸쉬업';
    } else if (isSelected4 == 'true') {
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
  void initWeight() async {
    String? storedWeight = await storage.read(key: 'weight');
    weight = storedWeight ?? '0';
    notifyListeners();
  }

  void deleteWeight() async {
    await storage.delete(key: 'weight');
    notifyListeners();
  }
}
