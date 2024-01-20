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
    await storage.delete(key: 'dataList');
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
}
