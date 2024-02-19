import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_app_bar.dart';
import 'package:escape_anchovy/src/screen/user_info/dialog/splash_select_dialog.dart';
import 'package:escape_anchovy/src/screen/user_info/user_info_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen(
      {super.key,
      required this.settingController,
      required this.userInfoController});

  static const routeName = '/user';

  final SettingsController settingController;
  final UserInfoController userInfoController;

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  void initState() {
    super.initState();
    _controller.loadData();
    _controller.returnName();
  }

  final _controller = UserInfoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: AppLocalizations.of(context)!.user_info_app_bar_title,
        isUserInfo: true,
        settingController: widget.settingController,
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
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return SplashSelectDialog(
                            settingsController: widget.settingController,
                            userInfoController: widget.userInfoController,
                          );
                        },
                      );
                    },
                    child: Stack(
                      children: [
                        returnSvgPicture(),
                        Positioned(
                            left: 0,
                            bottom: 3,
                            child: SvgPicture.asset(
                                'assets/svg/setting_circle.svg'))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: 80,
                    child: Center(
                      child: Text(
                        _controller.userName,
                        style: TextStyles.b1Medium.copyWith(
                            color: context.isLight
                                ? LightModeColors.blue
                                : DarkModeColors.blue),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '운동시작일자',
                        style: TextStyles.caption1.copyWith(
                            color: context.isLight
                                ? LightModeColors.dark3
                                : DarkModeColors.dark3),
                      ),
                      Text(
                        _controller.dataList.isEmpty
                            ? '운동기록 X'
                            : DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                _controller.dataList[0]['time'])),
                        style: TextStyles.b4Regular.copyWith(
                            color: context.isLight
                                ? LightModeColors.dark1
                                : DarkModeColors.dark1),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        '수행능력',
                        style: TextStyles.caption1.copyWith(
                            color: context.isLight
                                ? LightModeColors.dark3
                                : DarkModeColors.dark3),
                      ),
                      Text(
                        'LV.${widget.userInfoController.performanceLevel}',
                        style: TextStyles.b4Regular.copyWith(
                            color: context.isLight
                                ? LightModeColors.dark1
                                : DarkModeColors.dark1),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        '최대개수',
                        style: TextStyles.caption1.copyWith(
                            color: context.isLight
                                ? LightModeColors.dark3
                                : DarkModeColors.dark3),
                      ),
                      Text(
                        '최대개수 확인',
                        style: TextStyles.b4Regular.copyWith(
                            color: context.isLight
                                ? LightModeColors.dark1
                                : DarkModeColors.dark1),
                      ),
                      Container(
                        height: 1,
                        color: Colors.white,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '운동일수',
                        style: TextStyles.caption1.copyWith(
                            color: context.isLight
                                ? LightModeColors.dark3
                                : DarkModeColors.dark3),
                      ),
                      Text(
                        _controller.dataList.isNotEmpty
                            ? '${_controller.dataList.length.toString()}일'
                            : '0일',
                        style: TextStyles.b4Regular.copyWith(
                            color: context.isLight
                                ? LightModeColors.dark1
                                : DarkModeColors.dark1),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        '꾸준함',
                        style: TextStyles.caption1.copyWith(
                            color: context.isLight
                                ? LightModeColors.dark3
                                : DarkModeColors.dark3),
                      ),
                      Text(
                        'LV.${widget.userInfoController.stedayLevel}',
                        style: TextStyles.b4Regular.copyWith(
                            color: context.isLight
                                ? LightModeColors.dark1
                                : DarkModeColors.dark1),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              height: 1,
              color: context.isLight
                  ? LightModeColors.dark4
                  : DarkModeColors.dark4),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                _controller.userName,
                style: TextStyles.b1Medium.copyWith(
                    color: context.isLight
                        ? LightModeColors.blue
                        : DarkModeColors.blue),
              ),
              const Text(
                '님의 운동 히스토리',
                style: TextStyles.b1Medium,
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _controller.dataList.isNotEmpty
                      ? exLineChart1(context)
                      : Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  context.isLight ? Colors.black : Colors.white,
                              width: 1.0,
                            ),
                          ),
                          height: 100,
                          width: MediaQuery.of(context).size.width * 0.41,
                        ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    '운동항목1',
                    style: TextStyles.b2Regular,
                  )
                ],
              ),
              Column(
                children: [
                  _controller.dataList.isNotEmpty
                      ? exLineChart2(context)
                      : Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  context.isLight ? Colors.black : Colors.white,
                              width: 1.0,
                            ),
                          ),
                          height: 100,
                          width: MediaQuery.of(context).size.width * 0.41,
                        ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    '운동항목2',
                    style: TextStyles.b2Regular,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            '운동 알림 보내기',
            style: TextStyles.b1Medium,
          ),
        ],
      ),
    );
  }

  Widget returnSvgPicture() {
    if (widget.userInfoController.isSelected1) {
      return SvgPicture.asset('assets/svg/anchovy_circle.svg');
    } else if (widget.userInfoController.isSelected2) {
      return SvgPicture.asset('assets/svg/mackerel_circle.svg');
    } else if (widget.userInfoController.isSelected3) {
      return SvgPicture.asset('assets/svg/daegu_circle.svg');
    } else if (widget.userInfoController.isSelected4) {
      return SvgPicture.asset('assets/svg/shark_circle.svg');
    } else {
      return SvgPicture.asset('');
    }
  }

  Widget exLineChart1(BuildContext context) {
    final List<FlSpot> spots = [];

    for (int i = 0; i < _controller.dataList.length; i++) {
      int y = _controller.dataList[i]['ex1'][0];
      spots.add(FlSpot(i.toDouble(), y.toDouble()));
    }

    int maxEx1Value = _controller.dataList
        .map((data) => data['ex1'])
        .map((ex1List) => ex1List
            .reduce((value, element) => value > element ? value : element))
        .reduce((value, element) => value > element ? value : element);

    double getTouchLineStart(LineChartBarData barData, int spotIndex) {
      return 0;
    }

    double getTouchLineEnd(LineChartBarData barData, int spotIndex) {
      return 0;
    }

    return SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width * 0.41,
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(
              show: false,
            ),
            lineTouchData: LineTouchData(
              getTouchLineEnd: getTouchLineStart,
              getTouchLineStart: getTouchLineEnd,
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                getTooltipItems: (List<LineBarSpot> touchedSpots) {
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    final FlSpot spot = touchedSpot;
                    return LineTooltipItem('${spot.y.toInt().toString()}개',
                        TextStyles.b3Medium.copyWith(color: Colors.white));
                  }).toList();
                },
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                  spots: spots,
                  color: context.isLight ? Colors.blue : Colors.blue[400]),
            ],
            minX: 0,
            maxX: _controller.dataList.length.toDouble(),
            minY: 0,
            maxY: maxEx1Value.toDouble() + 4,
            borderData: FlBorderData(
                show: true,
                border: Border.all(
                    color: context.isLight ? Colors.black : Colors.white,
                    width: 1)),
            titlesData: const FlTitlesData(
                rightTitles: AxisTitles(),
                leftTitles: AxisTitles(),
                topTitles: AxisTitles(),
                bottomTitles: AxisTitles()),
          ),
        ));
  }

  Widget exLineChart2(BuildContext context) {
    final List<FlSpot> spots = [];

    for (int i = 0; i < _controller.dataList.length; i++) {
      int y = _controller.dataList[i]['ex2'][0];
      spots.add(FlSpot(i.toDouble(), y.toDouble()));
    }

    int maxEx2Value = _controller.dataList
        .map((data) => data['ex2'])
        .map((ex1List) => ex1List
            .reduce((value, element) => value > element ? value : element))
        .reduce((value, element) => value > element ? value : element);

    double getTouchLineStart(LineChartBarData barData, int spotIndex) {
      return 0;
    }

    double getTouchLineEnd(LineChartBarData barData, int spotIndex) {
      return 0;
    }

    int a = _controller.dataList[0]['ex2'][0];

    return SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width * 0.41,
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(
              show: false,
            ),
            lineTouchData: LineTouchData(
              getTouchLineEnd: getTouchLineStart,
              getTouchLineStart: getTouchLineEnd,
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                getTooltipItems: (List<LineBarSpot> touchedSpots) {
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    final FlSpot spot = touchedSpot;
                    return LineTooltipItem('${spot.y.toInt().toString()}개',
                        TextStyles.b3Medium.copyWith(color: Colors.white));
                  }).toList();
                },
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                  spots: spots,
                  color: context.isLight ? Colors.red : Colors.red[400]),
            ],
            minX: 0,
            maxX: _controller.dataList.length.toDouble(),
            minY: a.toDouble() - 5,
            maxY: maxEx2Value.toDouble() + 5,
            borderData: FlBorderData(
                show: true,
                border: Border.all(
                    color: context.isLight ? Colors.black : Colors.white,
                    width: 1)),
            titlesData: const FlTitlesData(
                rightTitles: AxisTitles(),
                leftTitles: AxisTitles(),
                topTitles: AxisTitles(),
                bottomTitles: AxisTitles()),
          ),
        ));
  }
}
