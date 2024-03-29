import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/src/common/common_dialog.dart';
import 'package:escape_anchovy/src/screen/user_info/user_info_controller.dart';
import 'package:escape_anchovy/src/screen/user_info/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashSelectDialog extends StatefulWidget {
  const SplashSelectDialog(
      {super.key,
      required this.settingsController,
      required this.userInfoController});

  final UserInfoController userInfoController;
  final SettingsController settingsController;

  @override
  State<SplashSelectDialog> createState() => _SplashSelectDialogState();
}

class _SplashSelectDialogState extends State<SplashSelectDialog> {
  final _controller = UserInfoController();

  @override
  void initState() {
    super.initState();
    _controller.loadSelectedList();
    _controller.loadMedalList();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, snapshot) {
        return CommonDialog(
          dialogHeight: 175,
          title: '스플래쉬 화면 설정',
          explain: '도전과제를 달성하면 메달을 얻을 수 있습니다',
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.userInfoController.isSelected1 = true;
                    widget.userInfoController.isSelected2 = false;
                    widget.userInfoController.isSelected3 = false;
                    widget.userInfoController.isSelected4 = false;
                  });
                },
                child: medal(
                    const Color(
                      0XFFC17931,
                    ),
                    widget.userInfoController.isSelected1,
                    'assets/svg/anchovy_medal.svg',
                    _controller.isClear1),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_controller.isClear2) {
                      widget.userInfoController.isSelected1 = false;
                      widget.userInfoController.isSelected2 = true;
                      widget.userInfoController.isSelected3 = false;
                      widget.userInfoController.isSelected4 = false;
                    }
                  });
                },
                child: medal(
                    const Color(
                      0XFF9C9CA5,
                    ),
                    widget.userInfoController.isSelected2,
                    'assets/svg/mackerel_medal.svg',
                    _controller.isClear2),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_controller.isClear3) {
                      widget.userInfoController.isSelected1 = false;
                      widget.userInfoController.isSelected2 = false;
                      widget.userInfoController.isSelected3 = true;
                      widget.userInfoController.isSelected4 = false;
                    }
                  });
                },
                child: medal(
                    const Color(
                      0XFFFED700,
                    ),
                    widget.userInfoController.isSelected3,
                    'assets/svg/daegu_medal.svg',
                    _controller.isClear3),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_controller.isClear4) {
                      widget.userInfoController.isSelected1 = false;
                      widget.userInfoController.isSelected2 = false;
                      widget.userInfoController.isSelected3 = false;
                      widget.userInfoController.isSelected4 = true;
                    }
                  });
                },
                child: medal(
                    const Color(
                      0XFF00D8FF,
                    ),
                    widget.userInfoController.isSelected4,
                    'assets/svg/shark_medal.svg',
                    _controller.isClear4),
              ),
            ],
          ),
          buttonHeight: 38,
          onPressed: () async {
            _controller.saveSelctedSplash(
                widget.userInfoController.isSelected1,
                widget.userInfoController.isSelected2,
                widget.userInfoController.isSelected3,
                widget.userInfoController.isSelected4);

            Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                pageBuilder: (BuildContext context,
                    Animation<double> animation1,
                    Animation<double> animation2) {
                  return UserInfoScreen(
                      settingController: widget.settingsController,
                      userInfoController: widget.userInfoController);
                },
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
              (route) => false,
            );
          },
        );
      },
    );
  }

  Widget medal(
      Color circleColor, bool isSelected, String src, bool isUnlocked) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: isSelected
                  ? context.isLight
                      ? LightModeColors.green
                      : DarkModeColors.green
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(30)),
      width: 50,
      height: 50,
      child: ClipOval(
        child: Center(
          child: Container(
            color: circleColor,
            width: 50,
            height: 50,
            child: SvgPicture.asset(
              isUnlocked ? src : 'assets/svg/question_mark_medal.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}
