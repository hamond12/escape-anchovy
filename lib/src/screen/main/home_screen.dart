import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/src/common/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.controller});

  static const routeName = '/home';

  final SettingsController controller;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        controller: widget.controller,
        title: AppLocalizations.of(context)!.home_app_bar_title,
        isLogo: true,
        isHome: true,
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
