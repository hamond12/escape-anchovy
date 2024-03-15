import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_svg.dart';
import 'package:escape_anchovy/src/screen/home/home_screen.dart';
import 'package:escape_anchovy/src/screen/user_info/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.title,
    this.settingController,
    this.isLogo = false,
    this.isHome = false,
    this.isUserInfo = false,
    this.isExercise = false,
  });

  final String title;
  final SettingsController? settingController;

  final bool isLogo;
  final bool isHome;
  final bool isUserInfo;
  final bool isExercise;

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(44.0);
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  void initState() {
    super.initState();

    if (widget.isHome) {
      widget.settingController!.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isHome || widget.isUserInfo) {
      widget.settingController!.theme =
          context.isLight ? 'dark_mode' : 'light_mode';
    }

    return AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            widget.title,
            style: TextStyles.h3Bold.copyWith(
                color: context.isLight
                    ? DarkModeColors.background
                    : LightModeColors.background),
          ),
        ),
        leadingWidth: 72,
        leading: widget.isLogo
            ? Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Image.asset(
                  context.isLight
                      ? 'assets/png/app_logo.png'
                      : 'assets/png/dark_app_logo.png',
                ),
              )
            : widget.isExercise
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomeScreen.routeName, (route) => false);
                    },
                    child: const Padding(
                        padding: EdgeInsets.fromLTRB(14, 14, 28, 14),
                        child: CommonSvg(
                          src: 'assets/svg/back.svg',
                        )),
                  ),
        actions: widget.isHome
            ? [
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, UserInfoScreen.routeName, (route) => false);
                    },
                    child: widget.settingController!.dataList.isEmpty
                        ? const SizedBox.shrink()
                        : const CommonSvg(src: 'assets/svg/user_info.svg')),
                const SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.settingController!.themeMode ==
                        ThemeMode.light) {
                      widget.settingController!
                          .updateThemeMode(ThemeMode.dark, 'light_mode');
                    } else {
                      widget.settingController!
                          .updateThemeMode(ThemeMode.light, 'dark_mode');
                    }
                  },
                  child: SvgPicture.asset(
                    'assets/svg/${widget.settingController!.theme}.svg',
                    height: 20,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ]
            : widget.isUserInfo
                ? [
                    const SizedBox(
                      width: 32,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.settingController!.country == 'korea') {
                          widget.settingController!.updateLocale('en', 'usa');
                        } else {
                          widget.settingController!.updateLocale('ko', 'korea');
                        }
                      },
                      child: SvgPicture.asset(
                        'assets/svg/${widget.settingController!.country}.svg',
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    )
                  ]
                : [
                    const SizedBox(
                      width: 72,
                    )
                  ]);
  }
}
