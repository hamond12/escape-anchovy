import 'package:escape_anchovy/notification.dart';
import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_dialog.dart';
import 'package:escape_anchovy/src/screen/user_info/user_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class TimeSelectDialog extends StatefulWidget {
  const TimeSelectDialog({super.key, required this.userInfoController});

  static const routeName = '/time_select';

  final UserInfoController userInfoController;

  @override
  State<TimeSelectDialog> createState() => _TimeSelectDialogState();
}

class _TimeSelectDialogState extends State<TimeSelectDialog> {
  final _controller = UserInfoController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      dialogHeight: 270,
      dialogPadding: 50,
      title: '알림시간 설정',
      explain: '선택한 시간에 매일 운동알림이 옵니다',
      bodySpacing: 15,
      body: TimePickerSpinner(
        is24HourMode: false,
        normalTextStyle: TextStyles.h2Regular.copyWith(
            color:
                context.isLight ? LightModeColors.dark3 : DarkModeColors.dark3),
        highlightedTextStyle: TextStyles.h2Regular.copyWith(
            color:
                context.isLight ? LightModeColors.dark1 : DarkModeColors.dark1),
        isForce2Digits: true,
        itemHeight: 50,
        itemWidth: 50,
        spacing: 8,
        onTimeChange: (time) {
          setState(() {
            widget.userInfoController.setHour = time.hour;
            widget.userInfoController.setMinute = time.minute;
          });
        },
      ),
      onPressed: () {
        _controller.setAlarmOn();

        widget.userInfoController.setAlarm = true;

        NotificationService.showScheduleNotification(
            hour: widget.userInfoController.setHour,
            minute: widget.userInfoController.setMinute,
            title: '멸치 탈출',
            body: '운동할 시간이에요!');

        Navigator.pop(context);
      },
    );
  }
}
