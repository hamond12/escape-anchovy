import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  const CommonButton(
      {super.key,
      this.width = double.maxFinite,
      this.height = 50,
      this.onPressed,
      this.text = '',
      this.textColor,
      this.backgroundColor,
      this.borderColor});

  final double width;
  final double height;
  final void Function()? onPressed;
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;

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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                color: widget.borderColor ?? Colors.transparent,
              ),
            ),
          ),
          child: Text(widget.text,
              style: TextStyles.b1Medium
                  .copyWith(color: widget.textColor ?? Colors.white))),
    );
  }
}
