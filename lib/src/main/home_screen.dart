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
      appBar: CommonAppBar(),
      body: _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
