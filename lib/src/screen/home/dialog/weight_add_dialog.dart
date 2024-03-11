import 'package:escape_anchovy/src/common/common_dialog.dart';
import 'package:flutter/material.dart';
import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/screen/home/home_controller.dart';

class WeightAddDialog extends StatefulWidget {
  const WeightAddDialog({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WeightAddDialogState();
  }
}

class _WeightAddDialogState extends State<WeightAddDialog> {
  final _controller = HomeController();

  @override
  void initState() {
    super.initState();
    _controller.loadWeight();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, snapshot) {
        return CommonDialog(
          dialogHeight: 180,
          dialogPadding: 40,
          title: '중량추가 설정',
          explain: '숫자를 눌러 추가할 중량을 설정해주세요',
          bodySpacing: 4,
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 78,
                  width: _controller.weightInputfieldHeight,
                  child: TextField(
                    maxLength: 2,
                    controller: _controller.weightController,
                    style: TextStyles.h1Bold.copyWith(
                        fontSize: 32,
                        color: context.isLight
                            ? DarkModeColors.background
                            : LightModeColors.background),
                    keyboardType: TextInputType.number,
                    showCursor: false,
                    onChanged: (value) {
                      setState(() {
                        if (_controller.weightController.text.isEmpty) {
                          _controller.weightInputfieldHeight = 24;
                        }
                        if (_controller.weightController.text.length == 2) {
                          if (_controller.weightController.text.contains('1')) {
                            _controller.weightInputfieldHeight = 36;
                            if (_controller.weightController.text
                                .contains('11')) {
                              _controller.weightInputfieldHeight = 32;
                            }
                          } else {
                            _controller.weightInputfieldHeight = 43;
                          }
                        }
                        if (_controller.weightController.text.length == 1) {
                          if (_controller.weightController.text.contains('1')) {
                            _controller.weightInputfieldHeight = 20;
                          } else {
                            _controller.weightInputfieldHeight = 24;
                          }
                        }
                      });
                    },
                    decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        hintText: _controller.weight,
                        hintStyle: TextStyles.h1Bold.copyWith(
                            fontSize: 32,
                            color: context.isLight
                                ? DarkModeColors.background
                                : LightModeColors.background)),
                  )),
              Text(
                'kg',
                style: TextStyles.h1Medium.copyWith(
                    color: context.isLight
                        ? DarkModeColors.background
                        : LightModeColors.background),
              ),
            ],
          ),
          buttonHeight: 42,
          onPressed: () {
            _controller.saveWeight();
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
