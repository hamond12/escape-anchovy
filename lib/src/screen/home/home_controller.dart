import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeController with ChangeNotifier {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  List<Map<String, dynamic>> dataList = [];

  Future<void> loadData() async {
    final String? jsonData = await storage.read(key: 'dataList');
    if (jsonData != null) {
      dataList = List<Map<String, dynamic>>.from(json.decode(jsonData));
      notifyListeners();
    }
  }

  //todo: ExerciseController로 옮기기
  Future<void> saveData() async {
    final String jsonData = json.encode(dataList);
    await storage.write(key: 'dataList', value: jsonData);
  }

  Future<void> deleteData() async {
    dataList.clear();
    await storage.delete(key: 'dataList');
    notifyListeners();
  }

  double returnListViewHeight() {
    if (dataList.length == 1) {
      return 63;
    } else if (dataList.length == 2) {
      return 140;
    } else {
      return 217;
    }
  }

  DateTime returnDataAddTime() {
    return DateTime.parse(dataList.last['time']).add(const Duration(days: 3));
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitHours = twoDigits(duration.inHours);
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }

  void checkTimeDifference() {
    if (dataList.isNotEmpty) {
      DateTime lastDataAddTime = DateTime.parse(dataList.last['time']);
      DateTime now = DateTime.now();
      if (now.difference(lastDataAddTime).inHours >= 72) {
        deleteData();
      }
    }
    notifyListeners();
  }

  late bool isSelected1;
  late bool isSelected2;
  late bool isSelected3;
  late bool isSelected4;

  HomeController() {
    isSelected1 = true;
    isSelected2 = false;
    isSelected3 = true;
    isSelected4 = false;
  }

  void loadCategory() async {
    isSelected1 = await getStorageBool('isSelected1') ?? true;
    isSelected2 = await getStorageBool('isSelected2') ?? false;
    isSelected3 = await getStorageBool('isSelected3') ?? true;
    isSelected4 = await getStorageBool('isSelected4') ?? false;
    notifyListeners();
  }

  void saveCategory() async {
    await storage.write(key: 'isSelected1', value: isSelected1.toString());
    await storage.write(key: 'isSelected2', value: isSelected2.toString());
    await storage.write(key: 'isSelected3', value: isSelected3.toString());
    await storage.write(key: 'isSelected4', value: isSelected4.toString());
    notifyListeners();
  }

  Future<bool?> getStorageBool(String key) async {
    String? value = await storage.read(key: key);
    return value != null ? value.toLowerCase() == 'true' : null;
  }

  bool isValidCategory() {
    if ((isSelected1 || isSelected2) && (isSelected3 || isSelected4)) {
      if ((isSelected1 && isSelected2) || (isSelected3 && isSelected4)) {
        return false;
      }
      return true;
    } else {
      return false;
    }
  }

  void setCategory() {}
}
