import 'dart:async';

import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/screen/main/home_screen.dart';
import 'package:escape_anchovy/src/screen/splash/splash_controller.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _controller = SplashController();

  @override
  void initState() {
    super.initState();

    _controller.moveUp();

    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFCCE9FF),
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, snapshot) {
            return _buildPage(context);
          }),
    );
  }

  Widget _buildPage(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          Positioned(
              top: screenHeight * 0.15,
              left: 0,
              right: 0,
              child: Text('ESCAPE\nENCHOVY',
                  textAlign: TextAlign.center,
                  style: TextStyles.title.copyWith(
                      color: context.isLight
                          ? LightModeColors.gray
                          : DarkModeColors.gray))),
          Positioned(
              bottom: 0,
              top: _controller.enchovyTopPos,
              right: 30,
              left: 0,
              child: Image.asset('assets/png/enchovy.png')),
          Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/png/wave.png',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.25,
                left: 0,
                right: 0,
                child: Center(
                  child: Transform.rotate(
                    angle: -2 * (3.141592653589793 / 180),
                    child: Text(
                        _controller.famousSaying[_controller.randomNumber],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: _controller.returnFamousSayingSize(),
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
            ],
          ),
          const Positioned(
            bottom: 18,
            left: 0,
            right: 0,
            child: Center(
              child: Text('Created by Hamond', style: TextStyles.b3Regular),
            ),
          ),
        ],
      ),
    );
  }
}
