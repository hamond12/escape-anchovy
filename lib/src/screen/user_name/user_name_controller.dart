import 'package:escape_anchovy/src/screen/main/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserNameController with ChangeNotifier {
  final storage = const FlutterSecureStorage();

  Future<void> savedName(BuildContext context) async {
    await storage.write(key: 'inputName', value: 'true');
    await storage.write(key: 'name', value: nameController.text);
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  final nameController = TextEditingController();
  final nameFocus = FocusNode();
  bool isNameInputting = false;
  bool isNameValid = false;

  final nameKey = GlobalKey<FormState>();

  void checkNameValidation(String value) {
    isNameValid = value.isNotEmpty;
    notifyListeners();
  }

  bool isLocaleKorean(BuildContext context) {
    if (AppLocalizations.of(context)!.app_title == '멸치 탈출') {
      return true;
    } else {
      return false;
    }
  }
}
