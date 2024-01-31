import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_app_bar.dart';
import 'package:escape_anchovy/src/screen/achievement/achievement_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AchievemnetScreen extends StatefulWidget {
  const AchievemnetScreen({super.key, required this.clearList});

  static const routeName = '/achievement';

  final List clearList;

  @override
  State<AchievemnetScreen> createState() => _AchievemnetScreenState();
}

class _AchievemnetScreenState extends State<AchievemnetScreen> {
  final _controller = AhhievementController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: '전체 업적 확인',
      ),
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, snapshot) {
            return _buildPage(context);
          }),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              achievementBox(
                  '멸치',
                  widget.clearList[0],
                  'assets/png/anchovy_outline.png',
                  const Color(0XFFCD8032),
                  '',
                  '',
                  isAnchovy: true),
              const SizedBox(
                width: 12,
              ),
              achievementBox(
                  '고등어',
                  widget.clearList[1],
                  'assets/png/mackerel_outline.png',
                  const Color(0XFF8A848D),
                  '최대개수 달성',
                  '턱걸이(10개), 푸쉬업(30개)')
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              achievementBox(
                  '대구',
                  widget.clearList[2],
                  'assets/png/daegu_outline.png',
                  const Color(0XFFFED700),
                  '최대개수 달성',
                  '고등어 해금조건에서 10kg 추가'),
              const SizedBox(
                width: 12,
              ),
              achievementBox(
                  '상어',
                  widget.clearList[3],
                  'assets/png/shark_outline.png',
                  const Color(0XFF00D8FF),
                  '최대개수 달성',
                  '대구 해금조건에서 10kg 추가')
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              achievementBox(
                  '떡잎',
                  widget.clearList[4],
                  'assets/png/cotyledon.png',
                  const Color(0XFFCD8032),
                  '꾸준함',
                  '1일차 달성'),
              const SizedBox(
                width: 12,
              ),
              achievementBox('새싹', widget.clearList[5], 'assets/png/sprout.png',
                  const Color(0XFF8A848D), '꾸준함', '1주일 달성')
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              achievementBox(
                  '어린나무',
                  widget.clearList[6],
                  'assets/png/sapling.png',
                  const Color(0XFFFED700),
                  '꾸준함',
                  '1달차 달성'),
              const SizedBox(
                width: 12,
              ),
              achievementBox('나무', widget.clearList[7], 'assets/png/tree.png',
                  const Color(0XFF00D8FF), '꾸준함', '100일차 달성')
            ],
          ),
          const Text('')
        ],
      ),
    );
  }

  Widget achievementBox(String title, bool isUnlock, String src,
      Color circleColor, String text1, String text2,
      {bool isAnchovy = false}) {
    return Container(
      height: 140,
      width: 150,
      decoration: BoxDecoration(
          border: Border.all(
              color: isUnlock
                  ? context.isLight
                      ? LightModeColors.green
                      : DarkModeColors.green
                  : context.isLight
                      ? LightModeColors.dark2
                      : DarkModeColors.dark2),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            isUnlock ? title : '??',
            style: TextStyles.b2Medium,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: context.isLight
                    ? LightModeColors.dark2
                    : DarkModeColors.dark2,
                width: 2.0,
              ),
            ),
            child: ClipOval(
              child: Center(
                child: Container(
                  color: circleColor,
                  width: 60,
                  height: 60,
                  child: Center(
                    child: isUnlock
                        ? Image.asset(src)
                        : SvgPicture.asset('assets/svg/question_mark.svg'),
                  ),
                ),
              ),
            ),
          ),
          isAnchovy
              ? const Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      '앱 최초실행',
                      style: TextStyles.caption1,
                    )
                  ],
                )
              : Column(
                  children: [
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      text1,
                      style: TextStyles.caption1,
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Text(
                      isUnlock ? text2 : '???',
                      style: TextStyles.caption2.copyWith(
                          color: context.isLight
                              ? LightModeColors.dark3
                              : DarkModeColors.dark3),
                    )
                  ],
                )
        ],
      ),
    );
  }
}
