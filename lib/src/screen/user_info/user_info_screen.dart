import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/src/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key, required this.controller});

  static const routeName = '/user';

  final SettingsController controller;

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: AppLocalizations.of(context)!.user_info_app_bar_title,
        isUserInfo: true,
        controller: widget.controller,
      ),
      body: _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return const Column(
      children: [],
    );
  }
}
