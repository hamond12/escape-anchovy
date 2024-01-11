import 'package:easy_localization/easy_localization.dart';
import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/main/home_screen.dart';
import 'package:escape_anchovy/src/user_info/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.title,
    this.isLogo = false,
    this.isHome = false,
    this.isUserInfo = false,
  });

  final String title;
  final bool isLogo;
  final bool isHome;
  final bool isUserInfo;

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(44.0);
}

class _CommonAppBarState extends State<CommonAppBar> {
  final storage = const FlutterSecureStorage();
  String? country = 'korea';

  void getCountry() async {
    country = await storage.read(key: 'country');
    print(country);
  }

  List<Widget> returnActions() {
    if (widget.isHome) {
      return [
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const UserInfoScreen()),
            );
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
      ];
    } else if (widget.isUserInfo) {
      return [
        const SizedBox(
          width: 32,
        ),
        GestureDetector(
          onTap: () {
            if (context.locale == const Locale('ko', 'KR')) {
              context.setLocale(const Locale('en', 'US'));
              storage.write(key: 'country', value: 'usa');
            } else {
              context.setLocale(const Locale('ko', 'KR'));
              storage.write(key: 'country', value: 'korea');
            }
            getCountry();
          },
          child: Image.asset(
            'assets/png/$country.png',
          ),
        ),
        const SizedBox(
          width: 16,
        )
      ];
    } else {
      return [
        const SizedBox(
          width: 72,
        )
      ];
    }
  }

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
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 28, 14),
                  child: SvgPicture.asset(
                    'assets/svg/back.svg',
                  ),
                ),
              ),
        actions: returnActions());
  }
}
