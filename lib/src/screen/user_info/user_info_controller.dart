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
      performanceLevel = '0';
    }
    notifyListeners();
  }
}
