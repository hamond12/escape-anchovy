import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserInfoController with ChangeNotifier {
  final storage = const FlutterSecureStorage();

  String userName = '';

  Future<void> returnName(BuildContext context) async {
    userName = (await storage.read(key: 'name'))!;
    notifyListeners();
  }
}
