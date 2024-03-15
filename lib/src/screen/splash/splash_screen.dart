import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/screen/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen(
      {super.key,
      required this.backgroundColor,
      required this.titleColor,
      required this.fish,
      required this.wave});

  static const routeName = '/splash';

  final Color backgroundColor;
  final Color titleColor;
  final String fish;
  final String wave;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _controller = SplashController();

  @override
  void initState() {
    super.initState();

    _controller.moveUp();
    _controller.checkInputName(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
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
                  style: TextStyles.title.copyWith(color: widget.titleColor))),
          Positioned(
              bottom: 0,
              top: _controller.topPos,
              right: 30,
              left: 0,
              child: SvgPicture.asset(widget.fish, fit: BoxFit.scaleDown)),
          Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  widget.wave,
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
          Positioned(
            bottom: 18,
            left: 0,
            right: 0,
            child: Center(
              child: Text('Created by Hamond',
                  style: TextStyles.b3Regular.copyWith(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}
