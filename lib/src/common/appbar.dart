import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key});

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(44.0);
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.isLight
          ? LightModeColors.background
          : DarkModeColors.background,
      title: Center(
        child: Text(
          '메인화면',
          style: TextStyles.h3Bold.copyWith(color: Colors.black),
        ),
      ),
      leadingWidth: 72,
      leading: Padding(
        padding: EdgeInsets.only(right: 8), // 또는 EdgeInsets.zero
        child: Image.asset(
          'assets/png/app_logo.png',
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            'assets/svg/user_info.svg',
            height: 20,
          ),
        ),
        SizedBox(
          width: 16,
        ),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            'assets/svg/darkmode.svg',
            height: 20,
          ),
        ),
        SizedBox(
          width: 16,
        ),
      ],
    );
  }
}
