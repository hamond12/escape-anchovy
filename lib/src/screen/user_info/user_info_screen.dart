import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_app_bar.dart';
import 'package:escape_anchovy/src/screen/user_info/user_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    _controller.loadPerformanceLevel();
    _controller.loadSteadyLevel();
  }

  final _controller = UserInfoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: AppLocalizations.of(context)!.user_info_app_bar_title,
        isUserInfo: true,
        settingsController: widget.settingController,
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
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 15,
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Image.asset('assets/png/anchovy_circle.png'),
                      Positioned(
                          left: 0,
                          bottom: 3,
                          child:
                              SvgPicture.asset('assets/svg/setting_circle.svg'))
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    _controller.userName,
                    style: TextStyles.h3Medium.copyWith(
                        color: context.isLight
                            ? LightModeColors.blue
                            : DarkModeColors.blue),
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
                        'asdf',
                        style: TextStyles.b4Regular.copyWith(
                            color: context.isLight
                                ? LightModeColors.dark1
                                : DarkModeColors.dark1),
                      ),
                      const SizedBox(
                        height: 8,
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
                        height: 8,
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
                        '${_controller.dataList.length.toString()}일',
                        style: TextStyles.b4Regular.copyWith(
                            color: context.isLight
                                ? LightModeColors.dark1
                                : DarkModeColors.dark1),
                      ),
                      const SizedBox(
                        height: 8,
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
                  : DarkModeColors.dark4)
        ],
      ),
    );
  }
}
