import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_button.dart';
import 'package:flutter/material.dart';

class CommonDialog extends StatefulWidget {
  const CommonDialog(
      {super.key,
      this.dialogPadding = 30,
      this.dialogHeight = 300,
      this.topPadding = 18,
      required this.title,
      this.titleSpacing = 2,
      required this.explain,
      this.bodySpacing = 20,
      required this.body,
      this.buttonHeight = 42,
      required this.onPressed});

  final double dialogPadding;
  final double dialogHeight;
  final double topPadding;
  final String title;
  final double titleSpacing;
  final String explain;
  final double bodySpacing;
  final Widget body;
  final double buttonHeight;
  final void Function()? onPressed;

  @override
  State<CommonDialog> createState() => _CommonDialogState();
}

class _CommonDialogState extends State<CommonDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: widget.dialogPadding),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: widget.topPadding),
          child: SizedBox(
            height: widget.dialogHeight,
            child: Column(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Text(widget.title, style: TextStyles.b2Medium),
                    SizedBox(
                      height: widget.titleSpacing,
                    ),
                    Text(
                      widget.explain,
                      style: TextStyles.b4Regular.copyWith(
                          color: context.isLight
                              ? LightModeColors.dark3
                              : DarkModeColors.dark3),
                    ),
                    SizedBox(
                      height: widget.bodySpacing,
                    ),
                    widget.body
                  ],
                )),
                CommonButton(
                  text: '완료',
                  height: widget.buttonHeight,
                  onPressed: widget.onPressed,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
