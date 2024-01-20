import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NoteController with ChangeNotifier {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  List<Map<String, dynamic>> dataList = [];

  Future<void> loadData() async {
    final String? jsonData = await storage.read(key: 'dataList');
    if (jsonData != null) {
      dataList = List<Map<String, dynamic>>.from(json.decode(jsonData));
    }
    notifyListeners();
  }

  Future<void> deleteData() async {
    await storage.delete(key: 'dataList');
  }

  int currentPage = 0;
  int itemsPerPage = 7;

  List<Map<String, dynamic>> get currentData {
    final startIndex = currentPage * itemsPerPage;
    final endIndex = dataList.length;
    return dataList.sublist(startIndex, endIndex);
  }

  int totalPage() {
    return dataList.length % 7 == 0
        ? dataList.length ~/ itemsPerPage
        : dataList.length ~/ itemsPerPage + 1;
  }

  void loadNextData() {
    if (currentPage + 1 < totalPage()) {
      currentPage++;
    }
    notifyListeners();
  }

  void loadPrevData() {
    if (currentPage != 0) {
      currentPage--;
      notifyListeners();
    }
  }
}
