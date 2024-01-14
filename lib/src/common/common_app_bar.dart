import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/screen/main/home_screen.dart';
import 'package:escape_anchovy/src/screen/user_info/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.title,
    this.controller,
    this.isLogo = false,
    this.isHome = false,
    this.isUserInfo = false,
  });

  final String title;
  final SettingsController? controller;
  final bool isLogo;
  final bool isHome;
  final bool isUserInfo;

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(44.0);
}

class _CommonAppBarState extends State<CommonAppBar> {
  String themeMode = 'dark_mode';

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: context.isLight
            ? LightModeColors.background
            : DarkModeColors.background,
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
                  'assets/png/app_logo.png',
                ),
              )
            : GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    HomeScreen.routeName,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 28, 14),
                  child: SvgPicture.asset(
                    'assets/svg/back.svg',
                  ),
                ),
              ),
        actions: widget.isHome
            ? [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, UserInfoScreen.routeName);
                  },
                  child: SvgPicture.asset(
                    'assets/svg/user_info.svg',
                    height: 20,
                    colorFilter: ColorFilter.mode(
                        context.isLight
                            ? DarkModeColors.background
                            : LightModeColors.background,
                        BlendMode.srcIn),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.controller!.themeMode == ThemeMode.light) {
                      widget.controller!
                          .updateThemeMode(ThemeMode.dark, 'light_mode');
                    } else {
                      widget.controller!
                          .updateThemeMode(ThemeMode.light, 'dark_mode');
                    }
                  },
                  child: SvgPicture.asset(
                    'assets/svg/${widget.controller!.theme}.svg',
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
                        if (widget.controller!.country == 'korea') {
                          widget.controller!.updateLocale('en', 'usa');
                        } else {
                          widget.controller!.updateLocale('ko', 'korea');
                        }
                      },
                      child: SvgPicture.asset(
                        'assets/svg/${widget.controller!.country}.svg',
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
