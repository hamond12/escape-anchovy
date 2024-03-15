import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/notification.dart';
import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_app_bar.dart';
import 'package:escape_anchovy/src/common/common_button.dart';
import 'package:escape_anchovy/src/common/common_svg.dart';
import 'package:escape_anchovy/src/screen/home/home_screen.dart';
import 'package:escape_anchovy/src/screen/user_info/dialog/splash_select_dialog.dart';

import 'package:escape_anchovy/src/screen/user_info/user_info_controller.dart';
import 'package:escape_anchovy/src/util/toast.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
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

  static of(BuildContext context) {}
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  void initState() {
    super.initState();

    _controller.loadData();
    _controller.loadUserName();
    _controller.loadAlarmInfo();

    _notification.initialAlarmPermission();
  }

  final _controller = UserInfoController();
  final _notification = NotificationService();

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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!(Navigator.of(context).canPop())) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        }
      },
      child: Padding(
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
                          returnCircle(),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                                  ? ''
                                  : DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          _controller.dataList[0]['time'])),
                              style: TextStyles.b4Regular.copyWith(
                                  color: context.isLight
                                      ? LightModeColors.dark1
                                      : DarkModeColors.dark1),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
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
                                  : '',
                              style: TextStyles.b4Regular.copyWith(
                                  color: context.isLight
                                      ? LightModeColors.dark1
                                      : DarkModeColors.dark1),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                          ],
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/svg/fire.svg'),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${_controller.getConsecutiveDays(_controller.dataList).toString()}일 연속 운동 중',
                          style: TextStyles.b3Medium.copyWith(
                              color: context.isLight
                                  ? LightModeColors.red
                                  : DarkModeColors.red),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
                height: 1,
                color: context.isLight
                    ? LightModeColors.dark4
                    : DarkModeColors.dark4),
            const SizedBox(
              height: 24,
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
              height: 20,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        _controller.dataList.isNotEmpty
                            ? exLineChart(
                                context,
                                'ex1',
                                '풀업',
                                context.isLight
                                    ? LightModeColors.blue
                                    : DarkModeColors.blue,
                                5)
                            : emptyBox(context),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          '풀업',
                          style: TextStyles.b2Regular,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        _controller.dataList.isNotEmpty
                            ? exLineChart(
                                context,
                                'ex2',
                                '푸쉬업',
                                context.isLight
                                    ? LightModeColors.red
                                    : DarkModeColors.red,
                                10)
                            : emptyBox(context),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          '푸쉬업',
                          style: TextStyles.b2Regular,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        _controller.dataList.isNotEmpty
                            ? exLineChart(
                                context,
                                'ex1',
                                '친업',
                                context.isLight
                                    ? LightModeColors.blue
                                    : DarkModeColors.blue,
                                5)
                            : emptyBox(context),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          '친업',
                          style: TextStyles.b2Regular,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        _controller.dataList.isNotEmpty
                            ? exLineChart(
                                context,
                                'ex2',
                                '너클 푸쉬업',
                                context.isLight
                                    ? LightModeColors.red
                                    : DarkModeColors.red,
                                10)
                            : emptyBox(context),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          '너클 푸쉬업',
                          style: TextStyles.b2Regular,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
                height: 1,
                color: context.isLight
                    ? LightModeColors.dark4
                    : DarkModeColors.dark4),
            const SizedBox(
              height: 24,
            ),
            const Text(
              '운동 알림 보내기',
              style: TextStyles.b1Medium,
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              child: Row(
                children: [
                  returnAlarmIcon(),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(widget.userInfoController.setAlarm
                      ? int.parse(widget.userInfoController.setHour!) < 12
                          ? '알람이 오전 ${int.parse(widget.userInfoController.setHour!)}시 ${int.parse(widget.userInfoController.setMinute!)}분에 울립니다.'
                          : '알람이 오후 ${int.parse(widget.userInfoController.setHour!) - 12}시 ${int.parse(widget.userInfoController.setMinute!)}분에 울립니다.'
                      : '알림설정을 진행해주세요')
                ],
              ),
              onTap: () {
                _notification.requestNotificationPermission();

                _notification.isAlarmPermissionAllow
                    ? timeSelectDialog(context)
                    : ToastUtil.showToast('알림권한을 허용해주세요.');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget returnAlarmIcon() {
    if (widget.userInfoController.setAlarm) {
      return const CommonSvg(src: 'assets/svg/alarm_on.svg');
    } else {
      return const CommonSvg(src: 'assets/svg/alarm_off.svg');
    }
  }

  Widget returnCircle() {
    if (widget.userInfoController.isSelected1) {
      return SvgPicture.asset('assets/svg/anchovy_circle.svg');
    } else if (widget.userInfoController.isSelected2) {
      return SvgPicture.asset('assets/svg/mackerel_circle.svg');
    } else if (widget.userInfoController.isSelected3) {
      return SvgPicture.asset('assets/svg/daegu_circle.svg');
    } else if (widget.userInfoController.isClear4) {
      return SvgPicture.asset('assets/svg/shark_circle.svg');
    } else {
      return SvgPicture.asset('');
    }
  }

  Widget emptyBox(context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width * 0.39,
    );
  }

  Widget exLineChart(BuildContext context, String ex, String exCategory,
      Color? color, int addY) {
    final List<FlSpot> spots = [];

    final List pullUp = [];
    final List chinUp = [];
    final List pushUp = [];
    final List nukclePushUp = [];

    for (int i = 0; i < _controller.dataList.length; i++) {
      int value = _controller.dataList[i][ex][0];
      if (_controller.dataList[i]['ex1_name'] == '풀업') {
        pullUp.add(value);
      }

      if (_controller.dataList[i]['ex1_name'] == '친업') {
        chinUp.add(value);
      }

      if (_controller.dataList[i]['ex2_name'] == '푸쉬업') {
        pushUp.add(value);
      }

      if (_controller.dataList[i]['ex2_name'] == '너클 푸쉬업') {
        nukclePushUp.add(value);
      }
    }

    int returnMaxExValue() {
      if (exCategory == '풀업') {
        return pullUp
            .reduce((value, element) => value > element ? value : element);
      }
      if (exCategory == '푸쉬업') {
        return pushUp
            .reduce((value, element) => value > element ? value : element);
      }
      if (exCategory == '친업') {
        return chinUp
            .reduce((value, element) => value > element ? value : element);
      }
      if (exCategory == '너클 푸쉬업') {
        return nukclePushUp
            .reduce((value, element) => value > element ? value : element);
      }
      return 0;
    }

    if (exCategory == '풀업') {
      for (int i = 0; i < pullUp.length; i++) {
        int y = pullUp[i];
        spots.add(FlSpot(i.toDouble(), y.toDouble()));
      }
    }
    if (exCategory == '푸쉬업') {
      for (int i = 0; i < pushUp.length; i++) {
        int y = pushUp[i];
        spots.add(FlSpot(i.toDouble(), y.toDouble()));
      }
    }
    if (exCategory == '친업') {
      for (int i = 0; i < chinUp.length; i++) {
        int y = chinUp[i];
        spots.add(FlSpot(i.toDouble(), y.toDouble()));
      }
    }
    if (exCategory == '너클 푸쉬업') {
      for (int i = 0; i < nukclePushUp.length; i++) {
        int y = nukclePushUp[i];
        spots.add(FlSpot(i.toDouble(), y.toDouble()));
      }
    }

    double getTouchLineStart(LineChartBarData barData, int spotIndex) {
      return 0;
    }

    double getTouchLineEnd(LineChartBarData barData, int spotIndex) {
      return 0;
    }

    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.width * 0.39,
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
                    int day = -1 * (spot.x.toInt() + 1 - spots.length);
                    int weight = _controller.dataList[spot.x.toInt()]['weight'];
                    return LineTooltipItem(
                        '', TextStyles.b4Medium.copyWith(color: Colors.white),
                        children: [
                          TextSpan(text: '${spot.y.toInt().toString()}개'),
                          TextSpan(text: weight != 0 ? ' ' : ''),
                          TextSpan(text: weight != 0 ? '(${weight}kg)' : ''),
                          const TextSpan(text: '\n'),
                          TextSpan(
                            text: day == 0 ? '지금' : '$day일 전',
                            style: TextStyles.b4Medium
                                .copyWith(color: const Color(0XFFD9D9D9)),
                          ),
                        ]);
                  }).toList();
                },
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                  spots: spots.length > 31
                      ? spots.sublist(spots.length - 31)
                      : spots,
                  color: color,
                  dotData: const FlDotData(show: false)),
            ],
            minX: spots.length > 31 ? spots.length - 31 : 0,
            maxX: spots.length.toDouble(),
            minY: 0,
            maxY: returnMaxExValue().toDouble() + addY,
            borderData: FlBorderData(
                show: true,
                border: Border.all(
                    color: context.isLight
                        ? DarkModeColors.background
                        : LightModeColors.background,
                    width: 1)),
            titlesData: const FlTitlesData(
                rightTitles: AxisTitles(),
                leftTitles: AxisTitles(),
                topTitles: AxisTitles(),
                bottomTitles: AxisTitles()),
          ),
        ));
  }

  timeSelectDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            contentPadding: const EdgeInsets.all(0),
            content: SizedBox(
                height: 300,
                child: Center(
                    child: Column(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('알림시간 설정', style: TextStyles.b2Medium),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '선택한 시간에 매일 운동알림이 옵니다',
                          style: TextStyles.b4Regular.copyWith(
                              color: context.isLight
                                  ? LightModeColors.dark3
                                  : DarkModeColors.dark3),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        TimePickerSpinner(
                          is24HourMode: false,
                          normalTextStyle: TextStyles.h2Regular.copyWith(
                              color: context.isLight
                                  ? LightModeColors.dark3
                                  : DarkModeColors.dark3),
                          highlightedTextStyle: TextStyles.h2Regular.copyWith(
                              color: context.isLight
                                  ? LightModeColors.dark1
                                  : DarkModeColors.dark1),
                          isForce2Digits: true,
                          itemHeight: 50,
                          itemWidth: 40,
                          spacing: 15,
                          onTimeChange: (time) {
                            _controller.setTime(time.hour, time.minute);
                            setState(() {
                              _controller.setHour = time.hour.toString();
                              _controller.setMinute = time.minute.toString();
                            });
                          },
                        ),
                      ],
                    )),
                    Row(
                      children: [
                        SizedBox(
                          width: 130,
                          child: CommonButton(
                            text: '알림설정',
                            height: 40,
                            onPressed: () {
                              setState(() {
                                widget.userInfoController.setAlarm = true;
                                widget.userInfoController.setHour =
                                    _controller.setHour;
                                widget.userInfoController.setMinute =
                                    _controller.setMinute;
                              });

                              _controller.setAlarmOn();

                              NotificationService.showScheduleNotification(
                                  hour: int.parse(_controller.setHour!),
                                  minute: int.parse(_controller.setMinute!),
                                  title: '멸치 탈출',
                                  body: '운동할 시간이에요!');

                              Navigator.pop(context);
                            },
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 130,
                          child: CommonButton(
                            text: '알림끄기',
                            height: 40,
                            backgroundColor: context.isLight
                                ? LightModeColors.red
                                : DarkModeColors.red,
                            onPressed: () {
                              setState(() =>
                                  widget.userInfoController.setAlarm = false);

                              _controller.setAlarmOff();

                              NotificationService.cancelNotification();

                              Navigator.pop(context);
                            },
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(15.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))),
          );
        });
  }
}
