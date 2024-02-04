import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserInfoController with ChangeNotifier {
  String userName = '';

  Future<void> returnName() async {
    userName = (await storage.read(key: 'name'))!;
    notifyListeners();
  }

  final storage = const FlutterSecureStorage();
  List<Map<String, dynamic>> dataList = [];

  Future<void> loadData() async {
    final String? jsonData = await storage.read(key: 'dataList');
    if (jsonData != null) {
      dataList = List<Map<String, dynamic>>.from(json.decode(jsonData));
    }
    notifyListeners();
  }

  late String performanceLevel;
  Future<void> loadPerformanceLevel() async {
    if (await storage.read(key: 'mackerel') == 'true' &&
        await storage.read(key: 'daegu') == null &&
        await storage.read(key: 'shark') == null) {
      performanceLevel = '1';
    } else if (await storage.read(key: 'mackerel') == 'true' &&
        await storage.read(key: 'daegu') == 'true' &&
        await storage.read(key: 'shark') == null) {
      performanceLevel = '2';
    } else if (await storage.read(key: 'mackerel') == 'true' &&
        await storage.read(key: 'daegu') == 'true' &&
        await storage.read(key: 'shark') == 'true') {
      performanceLevel = '3';
    } else {
      performanceLevel = '0';
    }
    notifyListeners();
  }

  late String stedayLevel;
  Future<void> loadSteadyLevel() async {
    if (await storage.read(key: 'cotyledon') == 'true' &&
        await storage.read(key: 'sprout') == null &&
        await storage.read(key: 'sapling') == null &&
        await storage.read(key: 'tree') == null) {
      stedayLevel = '1';
    } else if (await storage.read(key: 'cotyledon') == 'true' &&
        await storage.read(key: 'sprout') == 'true' &&
        await storage.read(key: 'sapling') == null &&
        await storage.read(key: 'tree') == null) {
      stedayLevel = '2';
    } else if (await storage.read(key: 'cotyledon') == 'true' &&
        await storage.read(key: 'sprout') == 'true' &&
        await storage.read(key: 'sapling') == 'true' &&
        await storage.read(key: 'tree') == null) {
      stedayLevel = '3';
    } else if (await storage.read(key: 'cotyledon') == 'true' &&
        await storage.read(key: 'sprout') == 'true' &&
        await storage.read(key: 'sapling') == 'true' &&
        await storage.read(key: 'tree') == 'true') {
      stedayLevel = '4';
    } else {
      stedayLevel = '0';
    }
    notifyListeners();
  }

  bool isClear1 = true;
  bool isClear2 = false;
  bool isClear3 = false;
  bool isClear4 = false;

  Future<void> loadMedalList() async {
    isClear1 = true;
    isClear2 = await storage.read(key: 'mackerel') == 'true';
    isClear3 = await storage.read(key: 'daegu') == 'true';
    isClear4 = await storage.read(key: 'shark') == 'true';
    notifyListeners();
  }

  late bool isSelected1;
  late bool isSelected2;
  late bool isSelected3;
  late bool isSelected4;

  Future<void> checkNotSelected() async {
    if (await storage.read(key: 'anchovy_medal') == null &&
        await storage.read(key: 'mackerel_medal') == null &&
        await storage.read(key: 'daegu_medal') == null &&
        await storage.read(key: 'shark_medal') == null) {
      await storage.write(key: 'anchovy_medal', value: 'true');
    }
  }

  Future<void> loadSelectedList() async {
    checkNotSelected();
    isSelected1 = await storage.read(key: 'anchovy_medal') == 'true';
    isSelected2 = await storage.read(key: 'mackerel_medal') == 'true';
    isSelected3 = await storage.read(key: 'daegu_medal') == 'true';
    isSelected4 = await storage.read(key: 'shark_medal') == 'true';
    notifyListeners();
  }

  Future<void> deleteSelctedSplash() async {
    await storage.delete(key: 'anchovy_medal');
    await storage.delete(key: 'mackerel_medal');
    await storage.delete(key: 'daegu_medal');
    await storage.delete(key: 'shark_medal');
    notifyListeners();
  }

  Future<void> saveSelctedSplash(bool a, bool b, bool c, bool d) async {
    await deleteSelctedSplash();
    if (a) {
      await storage.write(key: 'anchovy_medal', value: 'true');
    } else if (b) {
      await storage.write(key: 'mackerel_medal', value: 'true');
    } else if (c) {
      await storage.write(key: 'daegu_medal', value: 'true');
    } else if (d) {
      await storage.write(key: 'shark_medal', value: 'true');
    }
    notifyListeners();
  }
}
