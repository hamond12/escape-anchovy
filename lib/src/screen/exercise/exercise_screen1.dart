import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_app_bar.dart';
import 'package:escape_anchovy/src/common/common_button.dart';
import 'package:escape_anchovy/src/common/common_text_field.dart';
import 'package:escape_anchovy/src/screen/exercise/exercise_controller.dart';
import 'package:escape_anchovy/src/screen/exercise/timer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExerciseScreen1 extends StatefulWidget {
  const ExerciseScreen1({super.key, required this.exerciseController});

  final ExerciseController exerciseController;

  static const routeName = '/exercise1';

  @override
  State<ExerciseScreen1> createState() => _ExerciseScreen1State();
}

class _ExerciseScreen1State extends State<ExerciseScreen1> {
  final _controller = ExerciseController();

  @override
  void initState() {
    super.initState();
    _controller.loadEx1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: '운동',
        isExercise: true,
      ),
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, snapshot) {
            return _buildPage(context);
          }),
    );
  }

  Widget _buildPage(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        '${widget.exerciseController.set}/6 세트',
                        style: TextStyles.h1Bold,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      returnSvg(),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        returnCategoryName(),
                        style: TextStyles.h1Medium,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 260,
                        child: CommonTextField(
                          onChanged: (value) {
                            setState(() {
                              _controller.num1 = value;
                            });
                          },
                          textInputType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          hintText: '몇 개를 하셨나요?',
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        '정확한 측정을 위해 솔직하게 기입해주세요',
                        style: TextStyles.b4Regular,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 25),
                child: SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: CommonButton(
                      text: '완료',
                      onPressed: _controller.num1.isNotEmpty
                          ? () {
                              _controller.addEx1();
                              widget.exerciseController.set++;
                              Navigator.pushNamed(
                                  context, TimerScreen.routeName);
                            }
                          : null),
                ),
              ))
        ],
      ),
    );
  }

  Widget returnSvg() {
    if (widget.exerciseController.isSelected1 == true) {
      return SvgPicture.asset('assets/svg/pull_up_color.svg');
    } else if (widget.exerciseController.isSelected2 == true) {
      return SvgPicture.asset('assets/svg/chin_up_color.svg');
    } else {
      return SvgPicture.asset('');
    }
  }

  String returnCategoryName() {
    if (widget.exerciseController.isSelected1 == true) {
      return '풀업';
    } else if (widget.exerciseController.isSelected2 == true) {
      return '친업';
    } else {
      return '';
    }
  }
}
