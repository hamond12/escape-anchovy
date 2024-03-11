import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  const CommonButton({
    super.key,
    required this.text,
    this.width = double.maxFinite,
    this.height = 50,
    this.onPressed,
    this.textColor,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.borderColor,
    this.borderRadius,
  });

  final double width;
  final double height;
  final void Function()? onPressed;
  final String text;
  final Color? textColor;
  final Color? disabledBackgroundColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            backgroundColor: widget.backgroundColor ??
                (context.isLight ? LightModeColors.blue : DarkModeColors.blue),
            disabledBackgroundColor: widget.disabledBackgroundColor ??
                (context.isLight
                    ? LightModeColors.dark3
                    : DarkModeColors.dark3),
            shape: RoundedRectangleBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8.0),
              side: BorderSide(
                color: widget.borderColor ?? Colors.transparent,
              ),
            ),
          ),
          child: Text(widget.text,
              style: TextStyles.b2Medium
                  .copyWith(color: widget.textColor ?? Colors.white))),
    );
  }
}
