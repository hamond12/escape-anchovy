import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_svg.dart';
import 'package:escape_anchovy/src/screen/home/home_controller.dart';
import 'package:escape_anchovy/src/screen/home/home_screen.dart';
import 'package:escape_anchovy/src/screen/user_info/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.title,
    this.settingsController,
    this.isLogo = false,
    this.isHome = false,
    this.isUserInfo = false,
  });

  final String title;
  final SettingsController? settingsController;
  final bool isLogo;
  final bool isHome;
  final bool isUserInfo;

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(44.0);
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
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
            : GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.routeName, (route) => false);
                  HomeController().loadData;
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
                      Navigator.pushNamed(context, UserInfoScreen.routeName);
                    },
                    child: const CommonSvg(src: 'assets/svg/user_info.svg')),
                const SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.settingsController!.themeMode ==
                        ThemeMode.light) {
                      widget.settingsController!
                          .updateThemeMode(ThemeMode.dark, 'light_mode');
                    } else {
                      widget.settingsController!
                          .updateThemeMode(ThemeMode.light, 'dark_mode');
                    }
                  },
                  child: SvgPicture.asset(
                    'assets/svg/${widget.settingsController!.theme}.svg',
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
                        if (widget.settingsController!.country == 'korea') {
                          widget.settingsController!.updateLocale('en', 'usa');
                        } else {
                          widget.settingsController!
                              .updateLocale('ko', 'korea');
                        }
                      },
                      child: SvgPicture.asset(
                        'assets/svg/${widget.settingsController!.country}.svg',
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
