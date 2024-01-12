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
  String country = 'korea';

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: context.isLight
            ? LightModeColors.background
            : DarkModeColors.background,
        title: Center(
          child: Text(
            widget.title,
            style: TextStyles.h3Bold.copyWith(color: Colors.black),
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
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
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/svg/darkmode.svg',
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
                      child: Image.asset(
                        'assets/png/${widget.controller!.country}.png',
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
