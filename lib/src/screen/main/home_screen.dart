import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_app_bar.dart';
import 'package:escape_anchovy/src/common/common_button2.dart';
import 'package:escape_anchovy/src/screen/main/home_controller.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        controller: widget.controller,
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
                        Text(
                          '(자세한 설명 보기)',
                          style: TextStyles.b3Regular.copyWith(
                              color: context.isLight
                                  ? LightModeColors.dark2
                                  : DarkModeColors.dark2),
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
                      Column(
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
                      const SizedBox(
                        width: 16,
                      ),
                      SvgPicture.asset(
                        'assets/svg/dividing_line.svg',
                        colorFilter: ColorFilter.mode(
                            context.isLight
                                ? DarkModeColors.background
                                : LightModeColors.background,
                            BlendMode.srcIn),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/tea.svg',
                            colorFilter: ColorFilter.mode(
                                context.isLight
                                    ? DarkModeColors.background
                                    : LightModeColors.background,
                                BlendMode.srcIn),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            '휴식기간',
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
                      onPressed: () {},
                      text: '전체 일지 확인',
                      textStyle: TextStyles.caption2.copyWith(height: 0.01),
                    )
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  '당신의 성장과정을 살펴보세요.',
                  style: TextStyles.b3Regular.copyWith(
                      color: context.isLight
                          ? LightModeColors.dark2
                          : DarkModeColors.dark2),
                ),
                SizedBox(
                  height: 210,
                  child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final data = _controller.dataList[index];
                        return data != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    contentPadding:
                                        const EdgeInsets.only(left: 2),
                                    title: Text(
                                      '${data['day']}일차',
                                      style: TextStyles.b3Regular,
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
                                              '(${data['ex1'][0] + data['ex1'][1] + data['ex1'][2]}개)',
                                              style: TextStyles.b4Regular
                                                  .copyWith(
                                                      color: context.isLight
                                                          ? LightModeColors
                                                              .dark3
                                                          : DarkModeColors
                                                              .dark3),
                                            ),
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
                                            Text(
                                              '(${data['ex2'][0] + data['ex2'][1] + data['ex2'][2]}개)',
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
                              )
                            : const Column(
                                children: [],
                              );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Column(
                          children: [
                            Divider(
                              color: Color(0xFFEAEAEA),
                              height: 4,
                            )
                          ],
                        );
                      },
                      itemCount: 3),
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
                            onPressed: () {},
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
}
