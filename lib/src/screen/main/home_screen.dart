import 'package:easy_localization/easy_localization.dart';
import 'package:escape_anchovy/src/common/appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: tr('home_appbar_title'),
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
