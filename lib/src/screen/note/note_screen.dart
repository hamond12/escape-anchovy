import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_button.dart';
import 'package:escape_anchovy/src/screen/home/home_screen.dart';

import 'package:escape_anchovy/src/screen/note/note_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  static const routeName = '/note';

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _controller = NoteController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, snapshot) {
            return _buildPage(context);
          }),
    );
  }

  Widget _buildPage(BuildContext context) {
    return NestedScrollView(
        physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              actions: const [],
              leadingWidth: 0,
              leading: const SizedBox.shrink(),
              pinned: true,
              backgroundColor: context.isLight
                  ? LightModeColors.background
                  : DarkModeColors.background,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 72,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomeScreen.routeName, (route) => false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 14, 36, 14),
                        child: SvgPicture.asset(
                          'assets/svg/back.svg',
                          colorFilter: ColorFilter.mode(
                              context.isLight
                                  ? DarkModeColors.background
                                  : LightModeColors.background,
                              BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      '전체 일지 확인',
                      style: TextStyles.h3Bold,
                    ),
                  ),
                  const SizedBox(
                    width: 72,
                  ),
                ],
              ),
            )
          ];
        },
        body: _controller.dataList.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Text('3일 이상 운동을 하지 않으면 일지가 초기화됩니다.',
                          style: TextStyles.caption1.copyWith(
                              color: context.isLight
                                  ? LightModeColors.red
                                  : DarkModeColors.red)),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 38.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.76,
                            child: ListView.separated(
                                padding: EdgeInsets.zero,
                                controller: _scrollController,
                                itemBuilder: (context, index) {
                                  final data = _controller.dataList[index];

                                  int sum1 = (data['ex1'][0] +
                                      data['ex1'][1] +
                                      data['ex1'][2]);
                                  int sum2 = data['ex2'][0] +
                                      data['ex2'][1] +
                                      data['ex2'][2];

                                  Map<String, dynamic> sumMap = {
                                    '풀업': [],
                                    '친업': [],
                                    '푸쉬업': [],
                                    '너클 푸쉬업': []
                                  };

                                  List pullUpList = [];
                                  List chinUpList = [];
                                  List pushUpList = [];
                                  List nucklePushUpList = [];

                                  for (int i = 0; i <= index; i++) {
                                    Map<String, dynamic> data =
                                        _controller.dataList[i];
                                    if (data['ex1_name'] == '풀업') {
                                      int pullUpSum = data['ex1'][0] +
                                          data['ex1'][1] +
                                          data['ex1'][2];
                                      List pullUpExList = [
                                        data['ex1'][0],
                                        data['ex1'][1],
                                        data['ex1'][2]
                                      ];
                                      sumMap['풀업'].add(pullUpSum);
                                      pullUpList.add(pullUpExList);
                                    }
                                    if (data['ex1_name'] == '친업') {
                                      int chinUpSum = data['ex1'][0] +
                                          data['ex1'][1] +
                                          data['ex1'][2];
                                      List chinUpExList = [
                                        data['ex1'][0],
                                        data['ex1'][1],
                                        data['ex1'][2]
                                      ];
                                      sumMap['친업'].add(chinUpSum);
                                      chinUpList.add(chinUpExList);
                                    }
                                    if (data['ex2_name'] == '푸쉬업') {
                                      int pushUpSum = data['ex2'][0] +
                                          data['ex2'][1] +
                                          data['ex2'][2];
                                      List pushUpExList = [
                                        data['ex2'][0],
                                        data['ex2'][1],
                                        data['ex2'][2]
                                      ];
                                      sumMap['푸쉬업'].add(pushUpSum);
                                      pushUpList.add(pushUpExList);
                                    }
                                    if (data['ex2_name'] == '너클 푸쉬업') {
                                      int nucklePushUpSum = data['ex2'][0] +
                                          data['ex2'][1] +
                                          data['ex2'][2];
                                      List nucklePushUpExList = [
                                        data['ex2'][0],
                                        data['ex2'][1],
                                        data['ex2'][2]
                                      ];
                                      sumMap['너클 푸쉬업'].add(nucklePushUpSum);
                                      nucklePushUpList.add(nucklePushUpExList);
                                    }
                                  }

                                  List pullUpSumList = sumMap['풀업'];
                                  List chinUpSumList = sumMap['친업'];
                                  List pushUpSumList = sumMap['푸쉬업'];
                                  List nucklePushUpSumList = sumMap['너클 푸쉬업'];

                                  bool checkNotFirstEx1() {
                                    if (data['ex1_name'] == '풀업') {
                                      if (pullUpList[0][0] == data['ex1'][0] &&
                                          pullUpList[0][1] == data['ex1'][1] &&
                                          pullUpList[0][2] == data['ex1'][2]) {
                                        return false;
                                      } else {
                                        return true;
                                      }
                                    }
                                    if (data['ex1_name'] == '친업') {
                                      if (chinUpList[0][0] == data['ex1'][0] &&
                                          chinUpList[0][1] == data['ex1'][1] &&
                                          chinUpList[0][2] == data['ex1'][2]) {
                                        return false;
                                      } else {
                                        return true;
                                      }
                                    } else {
                                      return true;
                                    }
                                  }

                                  bool checkNotFirstEx2() {
                                    if (data['ex2_name'] == '푸쉬업') {
                                      if (pushUpList[0][0] == data['ex2'][0] &&
                                          pushUpList[0][1] == data['ex2'][1] &&
                                          pushUpList[0][2] == data['ex2'][2]) {
                                        return false;
                                      } else {
                                        return true;
                                      }
                                    }
                                    if (data['ex2_name'] == '너클 푸쉬업') {
                                      if (nucklePushUpList[0][0] ==
                                              data['ex2'][0] &&
                                          nucklePushUpList[0][1] ==
                                              data['ex2'][1] &&
                                          nucklePushUpList[0][2] ==
                                              data['ex2'][2]) {
                                        return false;
                                      } else {
                                        return true;
                                      }
                                    } else {
                                      return true;
                                    }
                                  }

                                  int returnSubtract1() {
                                    if (data['ex1_name'] == '풀업') {
                                      return (pullUpSumList[
                                              pullUpSumList.length - 1] -
                                          pullUpSumList[
                                              pullUpSumList.length - 2]);
                                    }
                                    if (data['ex1_name'] == '친업') {
                                      return (chinUpSumList[
                                              chinUpSumList.length - 1] -
                                          chinUpSumList[
                                              chinUpSumList.length - 2]);
                                    } else {
                                      return 0;
                                    }
                                  }

                                  int returnSubtract2() {
                                    if (data['ex2_name'] == '푸쉬업') {
                                      return (pushUpSumList[
                                              pushUpSumList.length - 1] -
                                          pushUpSumList[
                                              pushUpSumList.length - 2]);
                                    }
                                    if (data['ex2_name'] == '너클 푸쉬업') {
                                      return (nucklePushUpSumList[
                                              nucklePushUpSumList.length - 1] -
                                          nucklePushUpSumList[
                                              nucklePushUpSumList.length - 2]);
                                    } else {
                                      return 0;
                                    }
                                  }

                                  Widget returnString1() {
                                    if (returnSubtract1() > 0) {
                                      return Text(
                                        '${returnSubtract1()}↑',
                                        style: TextStyles.b3Bold.copyWith(
                                            color: context.isLight
                                                ? LightModeColors.red
                                                : DarkModeColors.red),
                                      );
                                    } else if (returnSubtract1() < 0) {
                                      return Text(
                                        '${-1 * returnSubtract1()}↓',
                                        style: TextStyles.b3Bold.copyWith(
                                            color: context.isLight
                                                ? LightModeColors.blue
                                                : DarkModeColors.blue),
                                      );
                                    } else {
                                      return Text('0',
                                          style: TextStyles.b3Bold.copyWith(
                                              color: context.isLight
                                                  ? LightModeColors.dark3
                                                  : DarkModeColors.dark3));
                                    }
                                  }

                                  Widget returnString2() {
                                    if (returnSubtract2() > 0) {
                                      return Text(
                                        '${returnSubtract2()}↑',
                                        style: TextStyles.b3Bold.copyWith(
                                            color: context.isLight
                                                ? LightModeColors.red
                                                : DarkModeColors.red),
                                      );
                                    } else if (returnSubtract2() < 0) {
                                      return Text(
                                        '${-1 * returnSubtract2()}↓',
                                        style: TextStyles.b3Bold.copyWith(
                                            color: context.isLight
                                                ? LightModeColors.blue
                                                : DarkModeColors.blue),
                                      );
                                    } else {
                                      return Text('0',
                                          style: TextStyles.b3Bold.copyWith(
                                              color: context.isLight
                                                  ? LightModeColors.dark3
                                                  : DarkModeColors.dark3));
                                    }
                                  }

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        contentPadding:
                                            const EdgeInsets.only(left: 2),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '${data['day']}일차',
                                                  style: TextStyles.b2Medium,
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                data['weight'] != 0
                                                    ? Text(
                                                        '(${data['weight']}kg)',
                                                        style: TextStyles
                                                            .b3Regular,
                                                      )
                                                    : const SizedBox.shrink()
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 3,
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
                                                  style: TextStyles.b3Medium,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  '${data['ex1'].join('  ')}',
                                                  style: TextStyles.b3Regular,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '($sum1개)',
                                                  style: TextStyles.b3Regular
                                                      .copyWith(
                                                          color: context.isLight
                                                              ? LightModeColors
                                                                  .dark3
                                                              : DarkModeColors
                                                                  .dark3),
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                data['day'] != 1 &&
                                                        checkNotFirstEx1()
                                                    ? returnString1()
                                                    : const SizedBox.shrink()
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '${data['ex2_name']}',
                                                  style: TextStyles.b3Medium,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  '${data['ex2'].join('  ')}',
                                                  style: TextStyles.b3Regular,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '($sum2개)',
                                                  style: TextStyles.b3Regular
                                                      .copyWith(
                                                          color: context.isLight
                                                              ? LightModeColors
                                                                  .dark3
                                                              : DarkModeColors
                                                                  .dark3),
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                data['day'] != 1 &&
                                                        checkNotFirstEx2()
                                                    ? returnString2()
                                                    : const SizedBox.shrink(),
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
                                  return const Divider(
                                    color: Color(0xFFEAEAEA),
                                    height: 4,
                                  );
                                },
                                itemCount: _controller.dataList.length),
                          )),
                    ],
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _scrollController.jumpTo(
                                0.0,
                              );
                            },
                            child: Text(
                              '↑ 맨 위로',
                              style: TextStyles.b1Regular.copyWith(
                                  color: context.isLight
                                      ? LightModeColors.dark2
                                      : DarkModeColors.dark2),
                            ),
                          ),
                          const SizedBox(width: 50),
                          GestureDetector(
                            onTap: () {
                              _scrollController.jumpTo(
                                _scrollController.position.maxScrollExtent,
                              );
                            },
                            child: Text(
                              '↓ 맨 아래로',
                              style: TextStyles.b1Regular.copyWith(
                                  color: context.isLight
                                      ? LightModeColors.dark2
                                      : DarkModeColors.dark2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.24),
                    SvgPicture.asset(
                      'assets/svg/no_data.svg',
                      height: 150,
                      colorFilter: ColorFilter.mode(
                        context.isLight
                            ? LightModeColors.dark3
                            : DarkModeColors.dark3,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      '운동기록이 없습니다',
                      style: TextStyles.h3Medium.copyWith(
                          color: context.isLight
                              ? LightModeColors.dark3
                              : DarkModeColors.dark3),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      '운동시작을 눌러 일지를 작성해보세요',
                      style: TextStyles.b2Regular.copyWith(
                          color: context.isLight
                              ? const Color(0XFFADA8B0)
                              : const Color(0XFF8A848D)),
                    ),
                    CommonButton(
                      text: '데이터 추가',
                      width: 300,
                      onPressed: () {
                        setState(() {
                          _controller.dataList.add({
                            'time': DateTime.now().toString(),
                            'day': _controller.dataList.length + 1,
                            'ex1_name': '친업',
                            'ex2_name': '너클 푸쉬업',
                            'ex1': [10, 5, 4],
                            'ex2': [30, 10, 1],
                            'weight': 0
                          });
                          _controller.saveData();
                        });
                      },
                    ),
                  ],
                ),
              ));
  }
}
