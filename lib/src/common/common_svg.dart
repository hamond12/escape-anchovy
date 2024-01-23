import 'package:escape_anchovy/res/text/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonSvg extends StatefulWidget {
  const CommonSvg({super.key, required this.src});

  final String src;

  @override
  State<CommonSvg> createState() => _CommonSvgState();
}

class _CommonSvgState extends State<CommonSvg> {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      widget.src,
      colorFilter: ColorFilter.mode(
          context.isLight
              ? DarkModeColors.background
              : LightModeColors.background,
          BlendMode.srcIn),
    );
  }
}
