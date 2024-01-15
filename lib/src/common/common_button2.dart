import 'package:escape_anchovy/res/text/colors.dart';
import 'package:flutter/material.dart';

class CommonButton2 extends StatefulWidget {
  const CommonButton2(
      {super.key,
      this.width = double.maxFinite,
      this.height = 50,
      this.onPressed,
      this.text = '',
      this.textStyle,
      this.buttonColor,
      this.backgroundColor,
      this.borderRadius = 10});

  final double width;
  final double height;
  final void Function()? onPressed;
  final String text;
  final TextStyle? textStyle;
  final Color? buttonColor;
  final Color? backgroundColor;
  final double borderRadius;

  @override
  State<CommonButton2> createState() => _CommonButton2State();
}

class _CommonButton2State extends State<CommonButton2> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0.0),
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            foregroundColor: widget.buttonColor ??
                (context.isLight ? LightModeColors.blue : DarkModeColors.blue),
            backgroundColor: widget.backgroundColor ??
                (context.isLight
                    ? LightModeColors.background
                    : DarkModeColors.background),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              side: BorderSide(
                  width: 0.8,
                  color: widget.buttonColor ??
                      (context.isLight
                          ? LightModeColors.blue
                          : DarkModeColors.blue)),
            ),
          ),
          child: Text(widget.text, style: widget.textStyle)),
    );
  }
}
