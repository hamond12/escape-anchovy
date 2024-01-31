import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeController with ChangeNotifier {
  // 데이터 관련
  final storage = const FlutterSecureStorage();
  List<Map<String, dynamic>> dataList = [];

  Future<void> deleteEx() async {
    await storage.delete(key: 'ex1');
    await storage.delete(key: 'ex2');
    notifyListeners();
  }

  Future<void> loadData() async {
    final String? jsonData = await storage.read(key: 'dataList');
    if (jsonData != null) {
      dataList = List<Map<String, dynamic>>.from(json.decode(jsonData));
    }
    notifyListeners();
  }

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

  // 일지 자동 초기화 관련

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

  // 운동항목 다이얼로그 관련

  bool isSelected1 = true; // 풀업
  bool isSelected2 = false; // 친업
  bool isSelected3 = true; // 푸쉬업
  bool isSelected4 = false; // 너클 푸쉬업

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

  void saveCategory() async {
    await storage.write(key: 'isSelected1', value: isSelected1.toString());
    await storage.write(key: 'isSelected2', value: isSelected2.toString());
    await storage.write(key: 'isSelected3', value: isSelected3.toString());
    await storage.write(key: 'isSelected4', value: isSelected4.toString());
    notifyListeners();
  }

  // 도전과제 관련

  void loadClear() {
    unlockMackerel();
    unlockDaegu();
    unlockShark();
  }

  void unlockMackerel() async {
    if (dataList.last['ex1'][0] >= 10 && dataList.last['ex2'][0] >= 30) {
      await storage.write(key: 'mackerel', value: 'true');
    }
  }

  void unlockDaegu() async {
    if ((dataList.last['ex1'][0] >= 10 && dataList.last['weight'] >= 10) &&
        (dataList.last['ex2'][0] >= 30 && dataList.last['weight'] >= 10)) {
      await storage.write(key: 'daegu', value: 'true');
    }
  }

  void unlockShark() async {
    if ((dataList.last['ex1'][0] >= 10 && dataList.last['weight'] >= 20) &&
        (dataList.last['ex2'][0] >= 30 && dataList.last['weight'] >= 20)) {
      await storage.write(key: 'shark', value: 'true');
    }
  }

  void deleteAchievement() async {
    await storage.delete(key: 'mackerel');
    await storage.delete(key: 'mackerel_toast');
    await storage.delete(key: 'daegu');
    await storage.delete(key: 'daegu_toast');
    await storage.delete(key: 'shark');
    await storage.delete(key: 'shark_toast');
  }

  void showInitialToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      fontSize: 16.0,
    );
  }

  void noticeClear() async {
    if (await storage.read(key: 'mackerel') == 'true') {
      if (await storage.read(key: 'mackerel_toast') != 'complete') {
        showInitialToast('고등어 도전과제를 달성했습니다!');
        await storage.write(key: 'mackerel_toast', value: 'complete');
      }
    }
    if (await storage.read(key: 'daegu') == 'true') {
      if (await storage.read(key: 'daegu_toast') != 'complete') {
        showInitialToast('대구 도전과제를 달성했습니다!');
        await storage.write(key: 'daegu_toast', value: 'complete');
      }
    }
    if (await storage.read(key: 'shark') == 'true') {
      if (await storage.read(key: 'shark_toast') != 'complete') {
        showInitialToast('상어 도전과제를 달성했습니다!');
        await storage.write(key: 'shark_toast', value: 'complete');
      }
    }
    notifyListeners();
  }

  List<bool> clearList = [true, false, false, false];
  Future<void> initClearList() async {
    clearList[1] = await storage.read(key: 'mackerel') == 'true';
    clearList[2] = await storage.read(key: 'daegu') == 'true';
    clearList[3] = await storage.read(key: 'shark') == 'true';
  }

  // 중량추가 다이얼로그 관련

  double weightInputfieldHeight = 24;
  final weightController = TextEditingController();

  String weight = '';
  Future<void> loadWeight() async {
    weight = await storage.read(key: 'weight') ?? '3';
    notifyListeners();
  }

  Future<void> saveWeight() async {
    await storage.write(
        key: 'weight',
        value: weightController.text.isEmpty ? weight : weightController.text);
    notifyListeners();
  }

  // 정보 가져오기

  Future<void> loadInformation() async {
    await loadData();
    loadClear();
    noticeClear();
    initClearList();
  }
}
