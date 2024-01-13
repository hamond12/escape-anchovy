import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonValidationMessage extends StatefulWidget {
  const CommonValidationMessage({
    super.key,
    this.isInputting = false,
    this.isValidation = false,
    this.passText = '',
    this.errorText = '',
  });

  final bool isInputting;
  final bool isValidation;
  final String passText;
  final String errorText;

  @override
  State<CommonValidationMessage> createState() =>
      _CommonValidationMessageState();
}

class _CommonValidationMessageState extends State<CommonValidationMessage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 4,
        ),
        widget.isInputting
            ? (widget.isValidation
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 2),
                      SvgPicture.asset(
                        'assets/svg/pass_circle.svg',
                        height: 12,
                      ),
                      const SizedBox(width: 3),
                      Text(widget.passText,
                          style: TextStyles.b4Regular.copyWith(
                            color: context.isLight
                                ? LightModeColors.green
                                : DarkModeColors.green,
                          ))
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 2),
                      SvgPicture.asset('assets/svg/error_circle.svg',
                          height: 12),
                      const SizedBox(width: 3),
                      Text(widget.errorText,
                          style: TextStyles.b4Regular.copyWith(
                              color: context.isLight
                                  ? LightModeColors.red
                                  : DarkModeColors.red))
                    ],
                  ))
            : const SizedBox.shrink(),
      ],
    );
  }
}
