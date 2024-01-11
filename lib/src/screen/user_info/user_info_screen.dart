import 'package:easy_localization/easy_localization.dart';
import 'package:escape_anchovy/src/common/appbar.dart';
import 'package:flutter/material.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CommonAppBar(title: tr('user_info_appbar_title'), isUserInfo: true),
      body: _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return const Column(
      children: [],
    );
  }
}
