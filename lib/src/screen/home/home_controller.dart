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
      return 60;
    } else if (dataList.length == 2) {
      return 135;
    } else {
      return 210;
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
}
