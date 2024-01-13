import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    super.key,
    this.height = 45.0,
    this.hintText = '',
    this.onTap,
    this.maxLength,
    this.onChanged,
    this.controller,
    this.focusNode,
  });

  final double height;
  final String hintText;
  final int? maxLength;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextField(
        onTap: widget.onTap,
        style: TextStyles.b1Regular.copyWith(decorationThickness: 0.0),
        maxLength: widget.maxLength,
        controller: widget.controller,
        focusNode: widget.focusNode,
        inputFormatters: null,
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          counterText: '',
          hintText: widget.hintText,
          hintStyle: TextStyles.b1Regular.copyWith(
              color:
                  context.isLight ? LightModeColors.gray : DarkModeColors.gray),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: context.isLight
                    ? LightModeColors.gray
                    : DarkModeColors.gray,
                width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: context.isLight
                    ? LightModeColors.gray
                    : DarkModeColors.gray,
                width: 1.0),
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        textAlignVertical: TextAlignVertical.bottom,
        onChanged: widget.onChanged,
      ),
    );
  }
}
