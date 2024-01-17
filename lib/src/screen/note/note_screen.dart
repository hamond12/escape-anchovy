import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_app_bar.dart';
import 'package:escape_anchovy/src/screen/main/home_controller.dart';
import 'package:escape_anchovy/src/screen/note/note_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key, required this.controller});

  static const routeName = '/note';

  final HomeController controller;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _controller = NoteController();

  @override
  void initState() {
    super.initState();
    _controller.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: '전체 일지 확인'),
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, snapshot) {
            return _buildPage(context);
          }),
    );
  }

  Widget _buildPage(BuildContext context) {
    List<Map<String, dynamic>> currentPageData = _controller.currentData;
    return _controller.dataList.isNotEmpty
        ? Column(
            children: [
              Expanded(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 6,
                  ),
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
                        height: 580,
                        child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final data = currentPageData[index];
                              final yData = index == 0
                                  ? currentPageData[0]
                                  : currentPageData[index - 1];
                              int sum1 = data['ex1'][0] +
                                  data['ex1'][1] +
                                  data['ex1'][2];
                              int sum2 = data['ex2'][0] +
                                  data['ex2'][1] +
                                  data['ex2'][2];
                              int ySum1 = yData['ex1'][0] +
                                  yData['ex1'][1] +
                                  yData['ex1'][2];
                              int ySum2 = yData['ex2'][0] +
                                  yData['ex2'][1] +
                                  yData['ex2'][2];

                              String returnSubtarct1() {
                                return sum1 - ySum1 > 0
                                    ? '${sum1 - ySum1}↑'
                                    : '${-1 * (sum1 - ySum1)}↓';
                              }

                              String returnSubtarct2() {
                                return sum2 - ySum2 > 0
                                    ? '${sum2 - ySum2}↑'
                                    : '${-1 * (sum2 - ySum2)}↓';
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    contentPadding:
                                        const EdgeInsets.only(left: 2),
                                    title: Text(
                                      '${data['day']}일차',
                                      style: TextStyles.b2Medium,
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
                                            data['day'] != 1
                                                ? Text(returnSubtarct1(),
                                                    style: TextStyles.b3Bold
                                                        .copyWith(
                                                      color: sum1 - ySum1 > 0
                                                          ? (context.isLight
                                                              ? LightModeColors
                                                                  .blue
                                                              : DarkModeColors
                                                                  .blue)
                                                          : (context.isLight
                                                              ? LightModeColors
                                                                  .red
                                                              : DarkModeColors
                                                                  .red),
                                                    ))
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
                                            data['day'] != 1
                                                ? Text(returnSubtarct2(),
                                                    style: TextStyles.b3Bold.copyWith(
                                                        color: sum2 - ySum2 > 0
                                                            ? (context.isLight
                                                                ? LightModeColors
                                                                    .blue
                                                                : DarkModeColors
                                                                    .blue)
                                                            : (context.isLight
                                                                ? LightModeColors
                                                                    .red
                                                                : DarkModeColors
                                                                    .red)))
                                                : const SizedBox.shrink()
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
                              return index != 6
                                  ? const Divider(
                                      color: Color(0xFFEAEAEA),
                                      height: 4,
                                    )
                                  : const SizedBox.shrink();
                            },
                            itemCount: currentPageData.length),
                      )),
                ],
              )),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => _controller.loadPrevData(),
                        child: const Text(
                          '<',
                          style: TextStyles.h3Regular,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${_controller.currentPage + 1}',
                        style: TextStyles.h3Regular,
                      ),
                      const Text(
                        ' / ',
                        style: TextStyles.h3Regular,
                      ),
                      Text(
                        '${_controller.dataList.length ~/ _controller.itemsPerPage + 1}',
                        style: TextStyles.h3Regular,
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => _controller.loadNextData(),
                        child: const Text(
                          '>',
                          style: TextStyles.h3Regular,
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
              ],
            ),
          );
  }
}
