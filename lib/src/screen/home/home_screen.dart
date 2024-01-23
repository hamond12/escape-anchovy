import 'dart:async';

import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_app_bar.dart';
import 'package:escape_anchovy/src/common/common_button.dart';
import 'package:escape_anchovy/src/common/common_button2.dart';
import 'package:escape_anchovy/src/common/common_svg.dart';
import 'package:escape_anchovy/src/screen/home/dialog/ex_category_dialog.dart';
import 'package:escape_anchovy/src/screen/home/home_controller.dart';
import 'package:escape_anchovy/src/screen/note/note_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.controller});

  static const routeName = '/home';

  final SettingsController controller;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = HomeController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.loadData();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      _controller.checkTimeDifference();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        settingsController: widget.controller,
        title: AppLocalizations.of(context)!.home_app_bar_title,
        isLogo: true,
        isHome: true,
      ),
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, snapshot) {
            return _buildPage(context);
          }),
    );
  }

  Widget _buildPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(context.isLight
                            ? 'assets/svg/heart.svg'
                            : 'assets/svg/dark_heart.svg'),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '운동하기',
                          style: TextStyles.b1Medium.copyWith(
                              color: context.isLight
                                  ? DarkModeColors.background
                                  : LightModeColors.background),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return explainDialog(context);
                              },
                            );
                          },
                          child: Text(
                            '(자세한 설명 보기)',
                            style: TextStyles.b3Regular.copyWith(
                                color: context.isLight
                                    ? LightModeColors.dark2
                                    : DarkModeColors.dark2),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const ExCategoryDialog();
                            },
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(context.isLight
                                ? 'assets/svg/exercise_category.svg'
                                : 'assets/svg/dark_exercise_category.svg'),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              '운동항목',
                              style: TextStyles.b1Regular.copyWith(
                                  color: context.isLight
                                      ? DarkModeColors.background
                                      : LightModeColors.background),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      const CommonSvg(src: 'assets/svg/dividing_line.svg'),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        children: [
                          const CommonSvg(src: 'assets/svg/weight.svg'),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            '중량추가',
                            style: TextStyles.b1Regular.copyWith(
                                color: context.isLight
                                    ? DarkModeColors.background
                                    : LightModeColors.background),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CommonButton2(
                  width: 180,
                  height: 40,
                  onPressed: () {},
                  text: '운동시작',
                  textStyle: TextStyles.b1Medium,
                  borderRadius: 8,
                )
              ],
            ),
          ),
          divideSection(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SvgPicture.asset(context.isLight
                              ? 'assets/svg/note.svg'
                              : 'assets/svg/dark_note.svg'),
                          const SizedBox(
                            width: 9,
                          ),
                          Text(
                            '최근 일지 확인',
                            style: TextStyles.b1Medium.copyWith(
                                color: context.isLight
                                    ? DarkModeColors.background
                                    : LightModeColors.background),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            '(3일)',
                            style: TextStyles.b3Regular.copyWith(
                                color: context.isLight
                                    ? LightModeColors.dark2
                                    : DarkModeColors.dark2),
                          )
                        ],
                      ),
                    ),
                    CommonButton2(
                      width: 65,
                      height: 18,
                      onPressed: () {
                        Navigator.pushNamed(context, NoteScreen.routeName);
                      },
                      text: '전체 일지 확인',
                      textStyle: TextStyles.caption2.copyWith(height: 0.01),
                    )
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '당신의 성장과정을 살펴보세요.',
                      style: TextStyles.b3Regular.copyWith(
                          color: context.isLight
                              ? LightModeColors.dark2
                              : DarkModeColors.dark2),
                    ),
                    _controller.dataList.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '일지 초기화까지',
                                style: TextStyles.caption1.copyWith(
                                    color: context.isLight
                                        ? LightModeColors.red
                                        : DarkModeColors.red),
                              ),
                              Text(
                                _controller.formatDuration(_controller
                                    .returnDataAddTime()
                                    .difference(DateTime.now())),
                                style: TextStyles.caption1.copyWith(
                                    color: context.isLight
                                        ? LightModeColors.red
                                        : DarkModeColors.red),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                _controller.dataList.isNotEmpty
                    ? SizedBox(
                        height: _controller.returnListViewHeight(),
                        child: ListView.separated(
                            controller: _scrollController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final data = _controller.dataList.length > 3
                                  ? _controller.dataList[
                                      index + _controller.dataList.length - 3]
                                  : _controller.dataList[index];

                              int sum1 = (data['ex1'][0] +
                                  data['ex1'][1] +
                                  data['ex1'][2]);
                              int sum2 = data['ex2'][0] +
                                  data['ex2'][1] +
                                  data['ex2'][2];

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    contentPadding:
                                        const EdgeInsets.only(left: 2),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${data['day']}일차',
                                          style: TextStyles.b3Regular,
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                      ],
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${data['ex1_name']}',
                                              style: TextStyles.b4Medium,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              '${data['ex1'].join('  ')}',
                                              style: TextStyles.b4Regular,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '($sum1개)',
                                              style: TextStyles.b4Regular
                                                  .copyWith(
                                                      color: context.isLight
                                                          ? LightModeColors
                                                              .dark3
                                                          : DarkModeColors
                                                              .dark3),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${data['ex2_name']}',
                                              style: TextStyles.b4Medium,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              '${data['ex2'].join('  ')}',
                                              style: TextStyles.b4Regular,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '($sum2개)',
                                              style: TextStyles.b4Regular
                                                  .copyWith(
                                                      color: context.isLight
                                                          ? LightModeColors
                                                              .dark3
                                                          : DarkModeColors
                                                              .dark3),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Column(
                                children: [
                                  Divider(
                                    color: Color(0xFFEAEAEA),
                                    height: 4,
                                  )
                                ],
                              );
                            },
                            itemCount: _controller.dataList.length),
                      )
                    : Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 18,
                            ),
                            SvgPicture.asset(
                              'assets/svg/no_data.svg',
                              colorFilter: ColorFilter.mode(
                                  context.isLight
                                      ? LightModeColors.dark3
                                      : DarkModeColors.dark3,
                                  BlendMode.srcIn),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '운동기록이 없습니다',
                              style: TextStyles.b2Medium.copyWith(
                                  color: context.isLight
                                      ? LightModeColors.dark3
                                      : DarkModeColors.dark3),
                            ),
                            Text(
                              '운동시작을 눌러 일지를 작성해보세요',
                              style: TextStyles.b4Regular.copyWith(
                                  color: context.isLight
                                      ? const Color(0XFFADA8B0)
                                      : const Color(0XFF8A848D)),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
          divideSection(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SvgPicture.asset(context.isLight
                              ? 'assets/svg/challenges.svg'
                              : 'assets/svg/dark_challenges.svg'),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            '도전과제',
                            style: TextStyles.b1Medium.copyWith(
                                color: context.isLight
                                    ? DarkModeColors.background
                                    : LightModeColors.background),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          CommonButton2(
                            width: 65,
                            height: 18,
                            onPressed: () {
                              setState(() {});
                              _controller.saveData();
                            },
                            text: '전체 업적 확인',
                            textStyle:
                                TextStyles.caption2.copyWith(height: 0.01),
                            buttonColor: context.isLight
                                ? LightModeColors.darkGold
                                : DarkModeColors.darkGold,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  '운동을 완료하고 도전과제를 달성해보세요.',
                  style: TextStyles.b3Regular.copyWith(
                      color: context.isLight
                          ? LightModeColors.dark2
                          : DarkModeColors.dark2),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: '고등어 ',
                    style: TextStyles.b3Regular.copyWith(
                        color: context.isLight
                            ? LightModeColors.blue
                            : DarkModeColors.blue),
                  ),
                  TextSpan(
                    text: '도전과제를 달성하면 무언가 바뀔수도?',
                    style: TextStyles.b3Regular.copyWith(
                        color: context.isLight
                            ? LightModeColors.dark2
                            : DarkModeColors.dark2),
                  )
                ])),
                const SizedBox(
                  height: 25,
                )
              ],
            ),
          ),
          CommonButton(
            text: '데이터 추가',
            width: 300,
            onPressed: () {
              setState(() {
                _controller.dataList.add({
                  'time': DateTime.now().toString(),
                  'day': _controller.dataList.length + 1,
                  'ex1_name': '풀업',
                  'ex2_name': '푸쉬업',
                  'ex1': [12, 10, 10],
                  'ex2': [10, 12, 10]
                });
                _controller.saveData();
              });
            },
          ),
          CommonButton(
            text: '데이터 삭제',
            width: 300,
            onPressed: () {
              _controller.deleteData();
            },
          ),
        ],
      ),
    );
  }

  Widget divideSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Container(
            height: 8,
            color:
                context.isLight ? LightModeColors.dark4 : DarkModeColors.dark4,
          ),
        ),
      ],
    );
  }

  Widget explainDialog(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.43,
      decoration: BoxDecoration(
        color:
            context.isLight ? LightModeColors.background : DarkModeColors.dark4,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(children: [
        const SizedBox(
          height: 14,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 36, // svgSize(24) + svgPadding(12)
            ),
            const Text(
              '운동설명',
              style: TextStyles.h2Bold,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                  )),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '운동방식',
                style: TextStyles.b1Medium,
              ),
              SizedBox(height: 4),
              Text(
                '운동시작을 누르면 2개의 종목을 번갈아가며 6세트를 진행합니다. 한 세마다 자신이 수행할 수 있는 최대의 개수를 수행해주세요. 오늘의 기록을 전날의 기록과 비교해서 볼 수 있습니다. 전날보다 1개씩 더하는 걸 목표로 삼아보세요!',
                style: TextStyles.b4Regular,
              ),
              SizedBox(height: 20),
              Text(
                '설정',
                style: TextStyles.b1Medium,
              ),
              SizedBox(height: 4),
              Text(
                '운동항목 아이콘을 눌러 2개의 항목을 선택해주세요. 휴식시간 아이콘을 눌러 세트별 휴식시간을 따로 설정할 수 있습니다. 휴식시간은 기본 2분으로 설정되있으며 휴식시간을 줄여나감으로써 운동강도를 높일 수 있습니다. ',
                style: TextStyles.b4Regular,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
